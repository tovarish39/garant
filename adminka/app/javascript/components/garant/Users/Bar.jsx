import React from "react";
import BarButton from "./BarButton";

export default ({
lang, onLanguageClick, checkedList, onSendButtonClick, usersStatus, onStatusClick, viewStatistic
}) => {
const trySelectedRu = (lang == 'Ru') ? 'selected' : 'not-selected'
const trySelectedEn = (lang == 'En') ? 'selected' : 'not-selected'

const trySelectedMember = (usersStatus == 'member') ? 'selected' : 'not-selected'
const trySelectedKicked = (usersStatus == 'kicked') ? 'selected' : 'not-selected'

const stateSendButton = (checkedList.length > 0) ? 'unlock' : 'lock'

console.log(viewStatistic)


return (
<div id="Bar">
    <div id="leftSideBar">
        <span>Активных пользователей Ru: {viewStatistic['active_ru_users']}</span>
        <span>Активных пользователей En: {viewStatistic['active_en_users']}</span>
        <span>Не активных Ru: {viewStatistic['inactive_ru_users']}</span>
        <span>Не активных En: {viewStatistic['inactive_en_users']}</span>
    </div>

    <div id="centerSideBar">
        <span>Количество рассмотренных споров</span>
        <span>--- за день: {viewStatistic['closed_disputes_by_day']}</span>
        <span>--- за неделю: {viewStatistic['closed_disputes_by_week']}</span>
        <span>--- за месяц: {viewStatistic['closed_disputes_by_month']}</span>
        <span>Количество не распределённых споров: {viewStatistic['opened_disputes']}</span>

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