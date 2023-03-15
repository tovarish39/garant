import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Users      from "../components/Users/Users";
import Deals      from "../components/Deals/Deals";
import Moderators from "../components/Moderators/Moderators";

export default (
  <Router>
    <Routes>
      <Route path="/"           element={<Users />} />
      <Route path="/moderators" element={<Moderators />} />
      <Route path="/deals"      element={<Deals />} />
    </Routes>
  </Router>
);