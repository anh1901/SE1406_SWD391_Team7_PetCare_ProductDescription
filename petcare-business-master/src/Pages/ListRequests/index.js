import React, { useEffect, useState } from 'react';

import HeaderEditPage from '../../Components/HeaderEditPage';
import SideBar from '../../Components/SideBar';
import SearchBox from '../../Components/SearchBox';
import OrderCard from '../../Components/OrderCard';
import Loading from '../../Components/Loading';
import BottomLoadMore from '../../Components/BottomLoadMore';

import api from '../../Services/api';

import { searchInList } from '../../Helpers/Functions';

import './styles.css';

export default function ListRequests(props) {
  // Button Load more
  const btnLoadMore = '.btn-load-more-orders';
  const hideClass = 'hide-button-load-more-orders';

  const [orders, setOrders] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [totalPages, setTotalPages] = useState(0);
  const [actPage, setActPage] = useState(0);

  async function loadOrdersFromCompany(page) {
    setOrders([
          {
              id: '1',
              date: "12-3-2022",
              statusOrder: "PROCESS",
              userCompleteName:"Anh",
          },
          {
              id: '2',
              date: "31-6-2022",
              statusOrder: "NOT_PAID",
              userCompleteName:"Em",
          },
          {
              id: '3',
              date: "21-6-2021",
              statusOrder: "DEVELIVERYING",
              userCompleteName:"Noise",
          },
          {
              id: '4',
              date: "20-4-2021",
              statusOrder: "FINISHED",
              userCompleteName:"Bois",
          }
    ]);
      setTotalPages(1);
      setActPage(10);
      setIsLoading(false);
      if (totalPages <= 1) {
        let btn = document.querySelector(btnLoadMore);
        if (btn !== null) {
          btn.classList.add(hideClass);
        }
      }
    // await api.get(`/get-orders-company/${page}`).then(res => {
    //   setOrders(res.data.content);
    //   setTotalPages(res.data.totalPages);
    //   setActPage(res.data.number);
    //   setIsLoading(false);
    //   if (res.data.totalPages <= 1) {
    //     let btn = document.querySelector(btnLoadMore);
    //     if (btn !== null) {
    //       btn.classList.add(hideClass);
    //     }
    //   }
    // });
  }

  useEffect(() => {
    loadOrdersFromCompany(0);
  }, []);

  useEffect(() => {
    if ((actPage + 1) >= totalPages) {
      let btn = document.querySelector(btnLoadMore);
      if (btn !== null) {
        btn.classList.add(hideClass);
      }
    }
  }, [actPage, totalPages]);

  async function loadMoreOrders(page) {
    await api.get(`/get-orders-company/${page}`).then(res => {
      setOrders(orders.concat(res.data.content));
      setActPage(res.data.number);
    });
  }

  return (
    <>
      <SideBar props={props} />
      <div className="container-page-sidebar">
        <HeaderEditPage requestsPage={true} />
        <div className="container-requests">
          <SearchBox searchMethod={(e) => searchInList(e, "input-search-search-box", "container-list-requests", "request", "name-person")} placeholder="Search for an order " />
          {isLoading? (<Loading />) : (
            <>
              <div id="container-list-requests" className="container-list-requests">
                {orders.map(order => <OrderCard key={order.id} order={order} />)}
              </div>
              <BottomLoadMore text="Load more orders" setClassName="btn-load-more-orders" onClick={() => loadMoreOrders((actPage + 1))} />
            </>
          )}
        </div>
      </div>
    </>
  );
}