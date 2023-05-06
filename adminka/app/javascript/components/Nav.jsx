import React from "react";
import { Link, NavLink } from "react-router-dom";

export default () => {
    
    const current_path = window.location.pathname

    return (
    <div id="Nav">
        
        <NavLink to="/">
            <button className={(current_path == '/') ? 'active' : ''}
            >Пользователи</button>
        </NavLink>

        <NavLink to="/garant/moderators">
            <button 
                className={(current_path == '/garant/moderators') ? 'active' : ''}
                >Модераторы</button>
        </NavLink>

        <NavLink to="/garant/deals">
            <button 
                className={(current_path == '/garant/deals') ? 'active' : ''}
                >Сделки</button>
        </NavLink>

        <NavLink to="/garant/finances">
            <button 
                className={(current_path == '/garant/finances') ? 'active' : ''}
                >Финансы</button>
        </NavLink>

    </div>
)}