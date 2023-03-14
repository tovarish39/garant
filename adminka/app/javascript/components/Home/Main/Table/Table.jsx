import React from "react";

function getFriendlyDateFormat(string){
    const date = new Date(string)
    return `(${date.getMinutes()}:${date.getHours()})   ${date.getDay()}-${date.toLocaleString('en-us',{month:'short', year:'numeric'})}`
}

export default ({users, lang, onCheckboxClick, onGeneralCheckboxClick}) => {
    const backendFormatLanguage = (lang == 'Ru') ? 'Русский' : 'English'

    const usersByLanguage = users.filter(user=> user.lang == backendFormatLanguage)

    return (
    <div id="Table" >
        <div id="TableHead">
            <div className="cell"><input id="general-checkbox" type="checkbox"  onClick={onGeneralCheckboxClick}/></div>        
            <div className="cell">telegram_id</div>
            <div className="cell">username</div>
            <div className="cell">дата регистрации</div>
            <div className="cell">количество сделок</div>
        </div>

        {usersByLanguage.map(user => (
            <div className="user-row" key={user.id} data-id={user.id}>
                <div className="cell cell-body"><input className="user-checkbox" type="checkbox" data-id={user.id} onClick={onCheckboxClick}/></div>        
                <span className="cell cell-body">{user.telegram_id}</span>
                <span className="cell cell-body">{user.username}</span>
                <span className="cell cell-body">{getFriendlyDateFormat(user.created_at)}</span>
                <span className="cell cell-body">{user.deals_size}</span>
            </div>
        ))}
    </div>
)}