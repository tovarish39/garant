import React from "react";
import BarButton from "./BarButton";

export default ({lang, onLanguageClick}) => {
    const try_selected_ru =  (lang == 'Ru') ? 'selected' : 'not-selected'
    const try_selected_en =  (lang == 'En') ? 'selected' : 'not-selected'

    return (
    <div id="Bar">
        <BarButton text={'Рассылка'} classs={'b-r-all'}/>
        
        <div id="ToggleLanguage">
            <BarButton text={'Ru'} onLanguageClick={onLanguageClick} classs={`b-r-left  ${try_selected_ru}`}/>
            <BarButton text={'En'} onLanguageClick={onLanguageClick} classs={`b-r-right ${try_selected_en}`}/>
        </div>
    </div>
)}