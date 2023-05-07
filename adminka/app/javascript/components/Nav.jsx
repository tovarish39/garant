import React from "react";
import { Link, NavLink } from "react-router-dom";
import NavGarant from './NavGarant'
import NavBlackList from './NavBlackList'

export default () => {

const current_path = window.location.pathname

return (
<div id="Nav">


    {current_path.includes('garant') && <NavGarant
        current_path={current_path}
        />}
    {current_path.includes('black_list') && <NavBlackList
        current_path={current_path}
        />}



    
    
    <div className="groupe2">
        <NavLink to="/garant/users">
            <button className={`rounded but-alone block ${current_path.includes('garant') ? 'active' : ''
                }`}>Garant</button>
        </NavLink>
        <NavLink to="/black_list/users">
            <button className={`rounded but-alone block ${current_path.includes('black_list') ? 'active' : ''
                }`}>Black-List</button>
        </NavLink>
    </div>
</div>
)}