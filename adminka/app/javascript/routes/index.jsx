import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Users      from "../components/Users/Users";
import Deals      from "../components/Deals/Deals";
import Moderators from "../components/Moderators/Moderators";
import Finances from "../components/Finances/Finances";

export default (
  <Router>
    <Routes>
      <Route path="/"           element={<Users />} />
      <Route path="/moderators" element={<Moderators />} />
      <Route path="/deals"      element={<Deals />} />
      <Route path="/finances"   element={<Finances />} />
    </Routes>
  </Router>
);