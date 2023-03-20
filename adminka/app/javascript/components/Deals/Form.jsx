import React from "react";
import $     from 'jquery'

export default ({
    isForm, 
    onCancelFormClick,
    onSubmit,
    isFinishClicked
})=>{
    
        const form = $('form')
        const is_active = (isForm) ? '' : 'none'
        if (isForm) {
            const top  = (window.innerHeight- form.height())/3
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
                            <input type="submit" value={(isFinishClicked)? 'Завершить': 'Отклонить'} className='form-button'/>
                            <button onClick={onCancelFormClick} className='form-button'>Отмена</button>
                        </div>
                    </form>
                </div>
            </div>
        )
}