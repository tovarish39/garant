import React, { useState , useEffect} from "react";
import $ from 'jquery'

import Bar          from "./Bar";
import TableActive  from "./TableActive";
import TableArchive from "./TableArchive";
import Form         from "./Form";

export default () => {
    const [isActive,        setIsActive]        = useState(true)
    const [deals,           setDeals]           = useState([])
    const [isForm,          setIsForm]          = useState(false)
    const [isFinishClicked, setIsFinishClicked] = useState(false) // or Reject clicked
    const [currentDealId,   setCurrentDealId]   = useState('')

    const X_CSRF_Token = $('meta[name="csrf-token"]').attr('content')

    useEffect(()=>{
        async function getDeals(){ 
            const res   = await fetch('/getDeals')
            const body  = await res.text()
            const deals = JSON.parse(body)
            setDeals(deals)
        }
// получение сделок
        getDeals() 
    }, [])

    function handleActiveClick(e){
        const clicked = e.target
        if (clicked.classList.contains('selected')) return

        const new_state = (clicked.innerHTML == 'активные') ? true : false 
        setIsActive(new_state)
    }
// "Завершить" 
    function handleFinishClick(e){
        const deal_id = e.target.dataset.id
        setCurrentDealId(deal_id)
        setIsFinishClicked(true)
        setIsForm(true)
    }
// 'Отклонить'
    function hangleRejectClick(e){
        const deal_id = e.target.dataset.id
        setCurrentDealId(deal_id)
        setIsFinishClicked(false)
        setIsForm(true)
    }

// отмена формы
function handleCancelFormClick(e){
    $("textarea[name='comment']").val('')
    setIsForm(false)
    e.preventDefault()
}
// отправка формы
    function handleSubmit(e){
        e.preventDefault()
        const deal_id = currentDealId
        const comment = $("textarea[name='comment']")
        const data = {
            deal_id:deal_id,
            administrator_action: (isFinishClicked) ? 'finished by_administrator' : 'canceled by_administrator',
            comment:comment.val()
        }
        const path = (isFinishClicked) 
            ? '/finishing_deal_by_administrator'
            : '/canceling_deal_by_administrator'
        fetch(path, {
            method:"POST",
            body:JSON.stringify(data),
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': X_CSRF_Token
              },
        })
        .then(res=>res.text())
        .then(body=>JSON.parse(body))
        .then(deals => {
            setDeals(deals)
            setIsForm(false)
        })
        comment.val('')
    }

    return (
        <div id="Main">
            <Bar
                isActive={isActive}
                onActiveClick={handleActiveClick}
                />
            {isActive && <TableActive
            activeDeals={deals.active}
            onFinishClick={handleFinishClick}
            onRejectClick={hangleRejectClick}
                />}
            {!isActive && <TableArchive
            archiveDeals={deals.archive}
                />}
            <Form 
                isForm={isForm}
                onCancelFormClick={handleCancelFormClick}
                onSubmit={handleSubmit}
                isFinishClicked={isFinishClicked}
                />
        </div>
    )
}