import React from 'react';

import PetCareLogo from '../../Assets/PetCareLogo';

import './styles.css';

export default function Footer() {
  return (
    <div className="container-footer">
      <div className="content-footer">
        <div className="left-side-footer">
          <div className="image-area">
            <PetCareLogo />
          </div>
          <div className="list-footer">
            <a href="/terms">Terms of services</a>
            <a href="/about">About us</a>
            <a href="/social-network">Social networks</a>
          </div>
        </div>
      </div>
    </div>
  );
}
