import React from "react";
import BarButton from "./BarButton";
import ToggleLanguage from "./ToggleLanguage";

export default () => (
    <div id="Bar">
        <BarButton text={'Рассылка'} border={'b-r-all'}/>
        <ToggleLanguage />
    </div>
)