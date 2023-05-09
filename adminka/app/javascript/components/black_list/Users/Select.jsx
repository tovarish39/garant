import React from "react"

export default ({onChangeStatus, blackListUser})=>{
    return (
        <select name="status_by_moderator"  onChange={onChangeStatus} data-id={blackListUser.id}>
            <option value={'Скамер'}>Скамер</option>
            <option value={'Не скамер'}>Не скамер</option>
            <option value={'Проверенный'}>Проверенный</option>
        </select>
    )
}
