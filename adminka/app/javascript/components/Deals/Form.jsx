import React from "react";
import $     from 'jquery'

export default ({
    isForm, 
    onCancelFormClick,
    onSubmit,
    actionButton
})=>{
    console.log(actionButton)
    const form = $('form')
    const is_active = (isForm) ? '' : 'none'
    if (isForm) {
        const top  = (window.innerHeight- form.height())/3
    }

    function getValue(actionButton) {
        switch (actionButton) {
            case 'finish': return 'Завершить';
            case 'reject': return 'Отклонить';
            case 'garant': return 'Гарант';
        }
    }

    return (
        <div className={is_active}>
            <div id="blanket" className="blanket"></div>
            <div id="form-wrap">
                <form style={{top:top}}
                 action="#"
                 method="post"
                 onSubmit={onSubmit}
                 >
                    <textarea name="comment" placeholder="Введите комментарий..." ></textarea>
                    
                    <div id="form-buttons">
                        <input type="submit" value={getValue(actionButton)} className='form-button'/>
                        <button onClick={onCancelFormClick} className='form-button'>Отмена</button>
                    </div>
                </form>
            </div>
        </div>
    )
}