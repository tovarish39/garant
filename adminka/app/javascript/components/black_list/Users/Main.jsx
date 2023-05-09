import React, {useState, useEffect} from "react";
import Table from "./Table";

export default () =>{
  const [blackListUsers, setBlackListUsers] = useState([])



  useEffect(()=>{
    async function getBlackListUsers(){ 
        const res   = await fetch('/getBlackListUsers')
        const body  = await res.text()
        const users = JSON.parse(body)
        setBlackListUsers(users)
    }
    
    getBlackListUsers()
}, [])
// изменение статуса
function handleChangeStatus(e){
  const black_list_user_id = e.target.dataset.id
  const newStatus    = e.target.value
  const data = {
      // moderator_id:moderator_id,
      newStatus:newStatus
  }

  fetch(`/black_list/users/${black_list_user_id}`, {
      method:"PUT",
      body:JSON.stringify(data),
      headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': X_CSRF_Token
        },
  })
  .then(res=>res.text())
  .then(body=>JSON.parse(body))
  .then(moderators => {
      // setModerators(moderators)
  })
}
return (
  <div id="Main">


      <Table
        blackListUsers={blackListUsers}
        onChangeStatus={handleChangeStatus}
        />

  </div>
)
}
