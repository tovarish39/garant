import React from "react";

export default ({text, border}) => (
    <div id="BarButton" className={`unlocked ${border}`}>
        {text}
    </div>
)