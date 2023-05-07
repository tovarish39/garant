import React from "react";
import $     from 'jquery'

export default ({onClick, isForm, checkedList, onSubmit})=>{
    const form = $('form')
    const is_active = (isForm) ? '' : 'none'
    if (isForm) {
        const top  = (window.innerHeight- form.height())/3
    }

    return (
        <div className={is_active}>
            <div id="blanket" className="blanket"></div>
            <div id="form-wrap">
                <form style={{top:top}} action="/send_message_to_users" method="post" onSubmit={onSubmit}>
                    <textarea name="message" placeholder="Введите сообщение..." ></textarea>
                    
                    <div id="form-buttons">
                        <input type="submit" value={'Отправить'} className='form-button'/>
                        <button onClick={onClick} className='form-button'>Отмена</button>
                    </div>
                </form>
            </div>
        </div>
    )
}