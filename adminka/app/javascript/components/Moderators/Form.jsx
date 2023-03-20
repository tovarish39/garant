import React from "react";
import $     from 'jquery'

export default ({isForm, onCancelForm, onSubmit})=>{
    
        const form = $('form')
        const is_active = (isForm) ? '' : 'none'
        if (isForm) {
            const top  = (window.innerHeight- form.height())/3
        }
    
        return (
            <div className={is_active}>
                <div id="blanket" className="blanket"></div>
                <div id="form-wrap">
                    <form style={{top:top}} action="/create_moderator" method="post" onSubmit={onSubmit}>
                        <input name="telegram_id" placeholder="Введите telegram_id..." ></input>
                        
                        <div id="form-buttons">
                            <input type="submit" value={'Создать'} className='form-button'/>
                            <button onClick={onCancelForm} className='form-button'>Отмена</button>
                        </div>
                    </form>
                </div>
            </div>
        )
}