import React from "react";
import BarButton from "./BarButton";

export default ({
lang, onLanguageClick, checkedList, onSendButtonClick, usersStatus, onStatusClick
}) => {
const trySelectedRu = (lang == 'Ru') ? 'selected' : 'not-selected'
const trySelectedEn = (lang == 'En') ? 'selected' : 'not-selected'

const trySelectedMember = (usersStatus == 'member') ? 'selected' : 'not-selected'
const trySelectedKicked = (usersStatus == 'kicked') ? 'selected' : 'not-selected'

const stateSendButton = (checkedList.length > 0) ? 'unlock' : 'lock'

return (
<div id="Bar">
    <div id="leftSideBar">

        

    </div>

    <div id="rightSideBar">

        <div id="ToggleLanguage">
            <BarButton text={'Рассылка'} classs={`b-r-all w-10 m-b-1 mr-1 ${stateSendButton}`}
                onClick={onSendButtonClick} />
            <div>
                <BarButton text={'En'} onClick={onLanguageClick} classs={`b-r-left w-2 ${trySelectedEn}`} />
                <BarButton text={'Ru'} onClick={onLanguageClick} classs={`b-r-right w-2 ${trySelectedRu}`} />
            </div>
        </div>

        <div id="ToggleStatus">
            <BarButton text={'Активные'} onClick={onStatusClick} classs={`b-r-left w-10 ${trySelectedMember}`} />
            <BarButton text={'Не активные'} onClick={onStatusClick} classs={`b-r-right w-10 ${trySelectedKicked}`} />
        </div>
    </div>
</div>
)}