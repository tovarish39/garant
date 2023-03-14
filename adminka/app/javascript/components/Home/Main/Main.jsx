import React, {useState, useEffect} from "react";
import $     from 'jquery'
import Bar   from './Bar/Bar'
import Table from "./Table/Table";
import Form  from './Form/Form'


export default () => {
    const [users,       setUsers]       = useState([])
    const [language,    setLanguage]    = useState('Ru')
    const [checkedList, setCheckedList] = useState([])
    const [isForm,      setIsForm]      = useState(false)

    useEffect(()=>{
        async function getUsers(){ 
            const res   = await fetch('/getUsers')
            const body  = await res.text()
            const users = JSON.parse(body)
            setUsers(users)
        }
        getUsers()
    }, [])
// кнопка "Рассылка"
    function handleSendButtonClick(e){
        const button = e.target
        if (button.classList.contains('lock')) return

        setIsForm(true)

    }


// кнопка изменения языка
    function handleLanguageClick(e) {
        const selectedLanguage = e.target.innerHTML
        setLanguage(selectedLanguage)
        const generalCheckbox = $("#general-checkbox")
        if (generalCheckbox.is(':checked')) generalCheckbox.trigger('click')
        setCheckedList([])
    }

    function clickingToAllCheckboxes(userCheckboxes, is_checked){
        const userIds = []
        userCheckboxes.each(((_i, checkbox)=>{
            const userId = checkbox.dataset.id 
            checkbox.checked = is_checked
            userIds.push(userId)
        }))
        return userIds
    }

// общий checkbox
    function handleGeneralCheckboxClick(e) {
        const userCheckboxes = $(".user-checkbox")
        const is_generalCheckboxChecked = e.target.checked
        if (is_generalCheckboxChecked){
            const userIds = clickingToAllCheckboxes(userCheckboxes, true)
            setCheckedList(userIds)
        } else {
            clickingToAllCheckboxes(userCheckboxes, false)
            setCheckedList([])
        }
    }

// чекбоксы с userId
    function handleCheckboxClick(e) {
        const userId = e.target.dataset.id
// добавление userId в список 
        if (e.target.checked){
            const newCheckedList = checkedList.concat([userId])
            setCheckedList(newCheckedList)
        } 
// удаление userId из список 
        else {
            const newCheckedList = checkedList.filter(checkedLaterUserId => checkedLaterUserId != userId ) 
            setCheckedList(newCheckedList)
        } 
    }

// отмена формы
    function handleClickCancelFormButton(e){
        setIsForm(false)
        e.preventDefault()
    }

// отправка формы
    function handleSubmit(e){
// если пустое сообщение или пробелы
        const message = $("textarea[name='message']").val()
        if (message.trim().length == 0) {
            e.preventDefault()
            alert('Сообщение не должно быть пустым')
            return
        }


        e.preventDefault()

        const data = {
            'message':message,
            'user_ids':checkedList
            }

        const X_CSRF_Token = $('meta[name="csrf-token"]').attr('content')
        fetch('/send_message_to_users', {
                method:"POST",
                body:JSON.stringify(data),
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': X_CSRF_Token
                    // 'Content-Type': 'application/x-www-form-urlencoded',
                  },
            }).then(res=>{
                if (res.status == 200) alert("cooбщение успешно отправлено")
                setIsForm(false)
                setCheckedList([])
                $('input[type="checkbox"]').each((_i, checkbox)=>{
                    checkbox.checked = false
                })
            })

    }


    return (
        <div id="Main">
            <Bar 
                lang={language} 
                checkedList={checkedList} 
                onLanguageClick={handleLanguageClick}
                onSendButtonClick={handleSendButtonClick}
                />
            <Table
              users={users}
              lang={language}
              onCheckboxClick={handleCheckboxClick}
              onGeneralCheckboxClick={handleGeneralCheckboxClick}
              />
            <Form 
                onClick={handleClickCancelFormButton}
                isForm={isForm}
                checkedList={checkedList}
                onSubmit={handleSubmit}
            />
        </div>
    )
}