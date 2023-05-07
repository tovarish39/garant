import React from "react";

export default ({activeDeals, onFinishClick, onRejectClick, onGarantClick})=>{

    function getFriendlyDateFormat(string){
        const date = new Date(string)
        return `(${date.getMinutes()}:${date.getHours()})   ${date.getDay()}-${date.toLocaleString('en-us',{month:'short', year:'numeric'})}`
    }

    return(
        <div id="Table">
            <div id="TableHead" className="fr8 f-s-07">
                <div className="cell8">Продавец <br/> telegram_id/username </div>
                <div className="cell8">Покупатель <br/> telegram_id/username </div>
                <div className="cell8">Условия</div>
                <div className="cell8">Сумма</div>
                <div className="cell8">Дата создания</div>
                <div className="cell8"></div>
                <div className="cell8"></div>
                <div className="cell8"></div>
            </div>  

            {activeDeals && activeDeals.map(deal => (
                <div className="row fr8 f-s-07" key={deal.id}>
                    <span className="cell8 cell8-body">{deal.custumer.telegram_id} / {deal.custumer.username}</span>
                    <span className="cell8 cell8-body">{deal.seller.telegram_id} / {deal.seller.username}</span>
                    <span className="cell8 cell8-body">{deal.conditions}</span>
                    <span className="cell8 cell8-body">{deal.currency} - {deal.amount}</span>
                    <span className="cell8 cell8-body">{getFriendlyDateFormat(deal.created_at)}</span>
                    <span className="cell8 cell8-body"><button onClick={onFinishClick} className="but-deal unlock" data-id={deal.id}>Завершить</button></span>
                    <span className="cell8 cell8-body"><button onClick={onRejectClick} className="but-deal unlock" data-id={deal.id}>Отклонить</button></span>
                    <span className="cell8 cell8-body"><button onClick={onGarantClick} className="but-deal unlock" data-id={deal.id}>Гарант</button></span>
                </div>
            ))}    
        </div>
    )
}