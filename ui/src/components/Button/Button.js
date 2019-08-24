import React from 'react';
import {FaBolt, FaCode, FaFileContract, FaKey, FaSync, FiPlayCircle} from "react-icons/all";

import "./Button.scss";

export default function ({onClick, icon, text, className}) {
  return (
    <button className={`soltty-btn ${className ? className : ''}`} onClick={onClick}>
      {icon === "circle" && <FiPlayCircle className="icon"/>}
      {icon === "key" && <FaKey className="icon"/>}
      {icon === "sync" && <FaSync className="icon"/>}
      {icon === "contract" && <FaFileContract className="icon"/>}
      {icon === "code" && <FaCode className="icon"/>}
      {icon === "bolt" && <FaBolt className="icon"/>}
      <span>{text}</span>
    </button>
  )
}
