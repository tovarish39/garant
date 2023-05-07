import React from "react";
import { Link, NavLink } from "react-router-dom";

export default ({current_path}) => {

return(
<div>
    <NavLink to="/garant/users">
        <button className={`rounded but-alone ${(current_path=='/garant/users' ) ? 'active' : ''
            }`}>Пользователи</button>
    </NavLink>

    <NavLink to="/garant/moderators">
        <button className={`rounded but-alone ${(current_path=='/garant/moderators' ) ? 'active' : ''
            }`}>Модераторы</button>
    </NavLink>

    <NavLink to="/garant/deals">
        <button className={`rounded but-alone ${(current_path=='/garant/deals' ) ? 'active' : '' }`}>Сделки</button>
    </NavLink>

    <NavLink to="/garant/finances">
        <button className={`rounded but-alone ${(current_path=='/garant/finances' ) ? 'active' : '' }`}>Финансы</button>
    </NavLink>
</div>
)
}