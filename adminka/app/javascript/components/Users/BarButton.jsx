import React from "react";

export default ({text, classs, onClick}) => (
    <div id="BarButton" onClick={onClick} className={classs}>
        {text}
    </div>
)