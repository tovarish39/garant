import React from "react"

export default ({onChangeStatus, moderator, rightsStatus})=>{
    function anotherStatus(rightsStatus){
        console.log(rightsStatus)
        if (rightsStatus == 'активный')    return 'не активный'
        if (rightsStatus == 'не активный') return 'активный'
    }
    return (
        <select name="rights_status"  onChange={onChangeStatus} data-id={moderator.id}>
            <option value={rightsStatus}>{rightsStatus}</option>
            <option value={anotherStatus(rightsStatus)}>{anotherStatus(rightsStatus)}</option>
        </select>
    )
}
