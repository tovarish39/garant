import React, {useState, useEffect} from "react";
import $     from 'jquery'
import Bar   from './Bar'
import Table from "./Table";
import Form  from './Form'

export default () => {
    const [moderators, setModerators] = useState([])

    useEffect(()=>{
        async function getModerators(){ 
            const res   = await fetch('/getModerators')
            const body  = await res.text()
            const moderators = JSON.parse(body)
            setModerators(moderators)
        }
        getModerators()
    }, [])



    return (
        <div id="Main">
            <Bar 
                />
            <Table
              />
            <Form 
            />
        </div>
    )
}