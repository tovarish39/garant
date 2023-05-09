import React from "react";
import BarButton from "../Users/BarButton";

export default ({isActive, onRightStatusClick, butTexts, disputes, onCreateClick, viewStatistic})=>{
const tryActive = ( isActive) ? 'selected' : 'not-selected'
const tryInactive = (!isActive) ? 'selected' : 'not-selected'

return(
<div id="Bar">

    <div id="leftSideBar">
    <span>Количество рассмотренных споров</span>
        <span>--- за день: {viewStatistic['closed_disputes_by_day']}</span>
        <span>--- за неделю: {viewStatistic['closed_disputes_by_week']}</span>
        <span>--- за месяц: {viewStatistic['closed_disputes_by_month']}</span>
        <span>Количество не распределённых споров: {viewStatistic['opened_disputes']}</span>


    </div>

    <div id="rightSideBar">
        <div>
            <BarButton text={'Создать'} classs={`b-r-all w-10 m-b-1 unlock`} onClick={onCreateClick} />
        </div>
        <div>
            <BarButton text={butTexts.active} onClick={onRightStatusClick} classs={`b-r-left w-10 ${tryActive}`} />
            <BarButton text={butTexts.inactive} onClick={onRightStatusClick} classs={`b-r-right w-10 ${tryInactive}`} />
        </div>

    </div>

</div>
)}