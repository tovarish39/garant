import React from "react";
import { Link, NavLink } from "react-router-dom";

export default ({current_path}) => {

return(
<div>
    <NavLink to="/black_list/users">
        <button className={`rounded but-alone ${(current_path=='/black_list/users' ) ? 'active' : ''
            }`}>Пользователи</button>
    </NavLink>
</div>
)}