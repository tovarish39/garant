import React from "react";

export default ({text, classs, onLanguageClick}) => (
    <div id="BarButton" onClick={onLanguageClick} className={classs}>
        {text}
    </div>
)