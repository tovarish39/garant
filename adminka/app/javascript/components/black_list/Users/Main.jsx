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

return (
  <div id="Main">


      <Table
        blackListUsers={blackListUsers}
        />

  </div>
)
}
