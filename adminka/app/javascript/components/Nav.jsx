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

        <NavLink to="/moderators">
            <button 
                className={(current_path == '/moderators') ? 'active' : ''}
                >Модераторы</button>
        </NavLink>

        <NavLink to="/deals">
            <button 
                className={(current_path == '/deals') ? 'active' : ''}
                >Сделки</button>
        </NavLink>

        <NavLink to="/finances">
            <button 
                className={(current_path == '/finances') ? 'active' : ''}
                >Финансы</button>
        </NavLink>

    </div>
)}