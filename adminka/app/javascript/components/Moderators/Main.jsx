import React, {useState, useEffect} from "react";
import $     from 'jquery'
import Bar   from './Bar'
import Table from "./Table";
import Form  from './Form'

export default () => {
    const [moderators,         setModerators]         = useState([])
    const [isActiveModerators, serIsActiveModerators] = useState(true)
    const [disputes,           setDisputes]           = useState([])
    const [isForm,             setIsForm]             = useState(false)

    const rightStatusButtonTexts = {active:'активные', inactive:'не активные'}
    const X_CSRF_Token = $('meta[name="csrf-token"]').attr('content')

    useEffect(()=>{
        async function getModerators(){ 
            const res   = await fetch('/getModerators')
            const body  = await res.text()
            const moderators = JSON.parse(body)
            setModerators(moderators)
        }
        async function getDisputes(){ 
            const res   = await fetch('/getDisputes')
            const body  = await res.text()
            const disputes = JSON.parse(body)
            setDisputes(disputes)
        }

// получение модераторов
        getModerators()
// получение споров
        getDisputes() // finished_by_day, finished_by_week, finished_by_month, pending_disputes 
    }, [])
// клик на 'активные' || 'не активные' 
    function handleRightStatusClick(e) {
        // если клик на активную кнопку
        const clickOnSeletedButton = e.target.classList.contains('selected')
        if (clickOnSeletedButton) return
        
        const activeText   = rightStatusButtonTexts.active
        const inactiveText = rightStatusButtonTexts.inactive

        const isToActive   = e.target.innerHTML == activeText   // 'активные' 
        const isToInactive = e.target.innerHTML == inactiveText // 'не активные'
        
        if      (isToActive)   serIsActiveModerators(true)
        else if (isToInactive) serIsActiveModerators(false)
    }

// 'создать' форму
    function handleCreateClick() {
        setIsForm(true)
    }
// 'отмена' формы
    function handleCancelForm(e) {
        e.preventDefault()
        $("input[name='telegram_id']").val('')
        setIsForm(false)
    }
// отправка формы
function handleSubmit(e){
    // если пустое сообщение или пробелы
            const telegram_id = $("input[name='telegram_id']").val()
            if (telegram_id.trim().length == 0) {
                e.preventDefault()
                alert('Сообщение не должно быть пустым')
                return
            }
    
    
            e.preventDefault()
    
            
            fetch('/create_moderator', {
                    method:"POST",
                    body:JSON.stringify({telegram_id:telegram_id,}),
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-Token': X_CSRF_Token
                      },
                })
                .then(res=>res.text())
                .then(body=>JSON.parse(body))
                .then(moderators => {
                    setModerators(moderators)
                    $("input[name='telegram_id']").val('')
                    setIsForm(false)
                })
    
        }

// изменение комментария
    function handleBlurComment(e){
        const moderator_id = e.target.dataset.id
        let   comment      = e.target.value
        const data = {
            moderator_id:moderator_id,
            comment:comment
        }

        fetch('/update_comment', {
            method:"POST",
            body:JSON.stringify(data),
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': X_CSRF_Token
              },
        })
        .then(res=>res.text())
        .then(body=>JSON.parse(body))
        .then(moderators => {
            setModerators(moderators)
        })
    }

// изменение статуса
    function handleChangeStatus(e){
        const moderator_id = e.target.dataset.id
        const newStatus    = e.target.value
        const data = {
            moderator_id:moderator_id,
            newStatus:newStatus
        }

        fetch('/update_status', {
            method:"POST",
            body:JSON.stringify(data),
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': X_CSRF_Token
              },
        })
        .then(res=>res.text())
        .then(body=>JSON.parse(body))
        .then(moderators => {
            setModerators(moderators)
        })
    }
    return (
        <div id="Main">
            <Bar
                isActive={isActiveModerators}
                onRightStatusClick={handleRightStatusClick} 
                butTexts={rightStatusButtonTexts}
                disputes={disputes}
                onCreateClick={handleCreateClick}
                />
            <Table
                moderators={moderators}
                isActive={isActiveModerators}
                onBlurComment={handleBlurComment}
                onChangeStatus={handleChangeStatus}
              />
            <Form 
                isForm={isForm}
                onCancelForm={handleCancelForm}
                onSubmit={handleSubmit}
            />
        </div>
    )
}