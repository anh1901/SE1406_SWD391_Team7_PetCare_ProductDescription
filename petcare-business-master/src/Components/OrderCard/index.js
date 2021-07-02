import React, { useEffect, useState } from 'react';

import './styles.css';

export default function OrderCard({ order }) {

  const [statusWord, setStatusWord] = useState('');

  useEffect(() => {
    switch (order.statusOrder) {
      case 'NOT_PAID':
        return setStatusWord("Pending");
      case 'PAID':
        return setStatusWord("Payment accept");
      case 'PROCESS':
        return setStatusWord("In progress");
      case 'DEVELIVERYING':
        return setStatusWord("Ready for delivery");
      case 'FINISHED':
        return setStatusWord("Finished");
      default:
        return 0;
    }
  }, [order.statusOrder]);

  // const date = order.createdOrderAt.split("-").join("/");
  return (
    <div className="request" role="button">
      <div className="header-person-from-request">
        <div className="request-person-information">
          <h3 className="name-person">{order.userCompleteName}</h3>
        </div>
      </div>
      <div className="request-information">
        <div className="header-request">
          <h3>Order: </h3>
          <span>{'#' + order.id}</span>
        </div>
        <div className="status-request-list">
          <h3>Status: </h3>
          <span>{statusWord}</span>
        </div>
        <div className="realized">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000000" strokeWidth="2" strokeLinecap="square" strokeLinejoin="arcs"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
          <span>{order.date}</span>
        </div>
      </div>
      <div className="button-area-see-details">
        <div className="button-area">
          <a href={`/requests/${order.id}`}>See details</a>
        </div>
      </div>
    </div>
  );
}
