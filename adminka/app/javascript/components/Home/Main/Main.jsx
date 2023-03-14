import React, {useState} from "react";
// import { render } from "react-dom";
import Bar from './Bar/Bar'
import Table from "./Table/Table";

export default () => {
    const [language, setLanguage] = useState('Ru')

    function handleLanguageClick(e) {
        const selectedLanguage = e.target.innerHTML
        setLanguage(selectedLanguage)
    }

    return (
        <div id="Main">
            <Bar lang={language} onLanguageClick={handleLanguageClick} />
            <Table />
        </div>
    )
}