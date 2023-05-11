import React from "react"

export default ({onChangeStatus, blackListUser})=>{
    console.log(blackListUser)
    const setCurrentStatus = (blackListUser) => {
        if (blackListUser.status_by_moderator == 'Проверенный') {
            currentStatus =  'Проверенный'
            return
        }
        currentStatus = blackListUser.is_self_scamer
    }
    const setAnotherStatuses = () => {
        avalibleStatuses.forEach((status)=>{
            if (status != currentStatus)
            anotherStatuses.push(status)
        })
    }

    const avalibleStatuses = [ 'Скамер', 'Не скамер', 'Проверенный']
    
    let currentStatus = ''
    const anotherStatuses = []

    setCurrentStatus(blackListUser)
    setAnotherStatuses()


// console.log(currentStatus)
// console.log(anotherStatuses)

    return (
        <select name="status_by_moderator"  onChange={onChangeStatus} data-id={blackListUser.id}>
            <option value={currentStatus}>{currentStatus}</option>
            <option value={anotherStatuses[0]}>{anotherStatuses[0]}</option>
            <option value={anotherStatuses[1]}>{anotherStatuses[1]}</option>
        </select>
    )
}
