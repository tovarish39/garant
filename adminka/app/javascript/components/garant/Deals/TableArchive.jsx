import React from "react";

export default ({archiveDeals})=>{

    function getFriendlyDateFormat(string){
        const date = new Date(string)
        return `(${date.getMinutes()}:${date.getHours()})   ${date.getDay()}-${date.toLocaleString('en-us',{month:'short', year:'numeric'})}`
    }

    function duration(start, finish){
        const duration = new Date(new Date(finish) - new Date(start))
        return `${duration.getDay()}:${duration.getHours()}:${duration.getMinutes()}`
    }

    function lostText(dispute){
        switch (dispute.dispute_lost) {
            case 'seller_lost':   return 'В пользу покупателя'
            case 'custumer_lost': return 'В пользу продавца'
            case 'all_lost':      return 'В пользу гаранта'
        }
    }

    function getFinishData(deal){
        // debugger
        switch (deal.status) {
            case 'canceled by_seller':        return 'Отменена продавцом'
            case 'finished by_custumer':      return 'Завершена покупателем'
            case 'finished by_administrator': return `Завершена администратором ${deal.dispute.comment_by_moderator}`
            case 'canceled by_administrator': return `Отменена администратором ${deal.dispute.comment_by_moderator}`
            case 'finished by_moderator':     return `Завершена модератором через спор. ${lostText(deal.dispute)}. ${deal.dispute.comment_by_moderator}`
            }
    }

    return(
        <div id="Table">
            <div id="TableHead" className="fr8 f-s-07">
                <div className="cell8">Продавец <br/> telegram_id/username </div>
                <div className="cell8">Покупатель <br/> telegram_id/username </div>
                <div className="cell8">Условия</div>
                <div className="cell8">Сумма</div>
                <div className="cell8">Дата создания</div>
                <div className="cell8">Дата завершения</div>
                <div className="cell8">Длительность сделки <br/> дд:чч:мм</div>
                <div className="cell8">Итог <br/> завершена / спор </div>
            </div>  

            {archiveDeals && archiveDeals.map(deal => (
                <div className="row fr8 f-s-07" key={deal.id}>
                    <span className="cell8 cell8-body">{deal.custumer.telegram_id} / {deal.custumer.username}</span>
                    <span className="cell8 cell8-body">{deal.seller.telegram_id} / {deal.seller.username}</span>
                    <span className="cell8 cell8-body">{deal.conditions}</span>
                    <span className="cell8 cell8-body">{deal.currency} - {deal.amount}</span>
                    <span className="cell8 cell8-body">{getFriendlyDateFormat(deal.created_at)}</span>
                    <span className="cell8 cell8-body">{getFriendlyDateFormat(deal.updated_at)}</span>
                    <span className="cell8 cell8-body">{duration(deal.created_at, deal.updated_at)}</span>
                    <span className="cell8 cell8-body">{getFinishData(deal)}</span>
                </div>
            ))}    
        </div>
    )
}