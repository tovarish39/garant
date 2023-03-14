import React from "react";
import BarButton from "./BarButton";

export default ({lang, onLanguageClick, checkedList, onSendButtonClick}) => {
    const trySelectedRu =  (lang == 'Ru') ? 'selected' : 'not-selected'
    const trySelectedEn =  (lang == 'En') ? 'selected' : 'not-selected'

    const stateSendButton = (checkedList.length > 0) ? 'unlock' : 'lock' 

    return (
    <div id="Bar">
        <BarButton 
            text={'Рассылка'} 
            classs={`b-r-all ${stateSendButton}`} 
            onClick={onSendButtonClick}/>
        
        <div id="ToggleLanguage">
            <BarButton 
                text={'Ru'} 
                onClick={onLanguageClick} 
                classs={`b-r-left  ${trySelectedRu}`}/>
            <BarButton 
                text={'En'} 
                onClick={onLanguageClick} 
                classs={`b-r-right ${trySelectedEn}`}/>
        </div>
    </div>
)}