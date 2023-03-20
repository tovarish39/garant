import React from "react";
import BarButton from "../Users/BarButton";

export default ({isActive, onRightStatusClick, butTexts, disputes, onCreateClick})=>{
    const tryActive   =  ( isActive)           ? 'selected' : 'not-selected'
    const tryInactive =  (!isActive)           ? 'selected' : 'not-selected'


    return(
        <div id="Bar">
            
            <div id="leftSideBar">
                <div>
                    <BarButton 
                    text={'Создать'} 
                    classs={`b-r-all w-10 m-b-1 unlock`} 
                    onClick={onCreateClick}
                    />
                </div>
                <div>
                    <BarButton 
                        text={butTexts.active} 
                        onClick={onRightStatusClick} 
                        classs={`b-r-left w-10 ${tryActive}`}/>
                    <BarButton 
                        text={butTexts.inactive} 
                        onClick={onRightStatusClick} 
                        classs={`b-r-right w-10  ${tryInactive}`}/>
                </div>
            </div>

            <div id="rightSideBar">
                <div>количество рассмотренных споров <br/>
                   --- за день   : {disputes.finished_by_day}<br/>
                   --- за неделю : {disputes.finished_by_week}<br/>
                   --- за месяц  : {disputes.finished_by_month}<br/>
                   количество не распределённых споров : {disputes.pending_disputes}
                
                </div>
            </div>
            
        </div>
)}