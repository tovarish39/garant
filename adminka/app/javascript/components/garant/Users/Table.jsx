import React from "react";

function getFriendlyDateFormat(string){
    const date = new Date(string)
    return `(${date.getMinutes()}:${date.getHours()})   ${date.getDay()}-${date.toLocaleString('en-us',{month:'short', year:'numeric'})}`
}

export default ({users, lang, onCheckboxClick, onGeneralCheckboxClick, usersStatus, searchTemplate}) => {
    const backendFormatLanguage = (lang == 'Ru') ? 'Русский' : 'English'
    const is_searchTemplateEmpty = searchTemplate.length == 0
 
    var regex = new RegExp(`^${searchTemplate}`, 'i')

    const filteresUsers = users.filter(user=> 
    // фильтр по языку
        (user.lang == backendFormatLanguage) && 
    // фильтр по "активный"/"не активный"
        (user.with_bot_status == usersStatus) &&
    // фильтр по поисковику  пустой поисковик || совпадение по телеграм ид || совпадение по юзернейму
        (is_searchTemplateEmpty || regex.test(user.telegram_id) || regex.test(user.username))
        )

    return (
    <div id="Table">
        <div id="TableHead" className="col-5 f-s-08">
            <div className="cell5"><input id="general-checkbox" type="checkbox"  onClick={onGeneralCheckboxClick}/></div>        
            <div className="cell5">telegram_id</div>
            <div className="cell5">username</div>
            <div className="cell5">дата регистрации</div>
            <div className="cell5">количество сделок</div>
        </div>

        {filteresUsers.map(user => (
            <div className="row col-5 f-s-07" key={user.id} data-id={user.id}>
                <div className="cell5 cell5-body"><input className="user-checkbox" type="checkbox" data-id={user.id} onClick={onCheckboxClick}/></div>        
                <span className="cell5 cell5-body">{user.telegram_id}</span>
                <span className="cell5 cell5-body">{user.username}</span>
                <span className="cell5 cell5-body">{getFriendlyDateFormat(user.created_at)}</span>
                <span className="cell5 cell5-body">{user.deals_size}</span>
            </div>
        ))}
    </div>
)}