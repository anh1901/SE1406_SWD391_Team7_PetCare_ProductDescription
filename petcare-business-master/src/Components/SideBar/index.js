import React, { useEffect } from 'react';

import FixedBar from '../../Components/FixedBar';
import Loading from '../../Components/Loading';

import PawLogo from '../../Assets/PawLogo';
import PetShopDogLogo from '../../Assets/PetShopDogLogo.svg';

import { isAuthenticated, logout } from '../../Services/auth';
import api from '../../Services/api';
import { useSelector, useDispatch } from 'react-redux';
import { setCompany, setIsLoading, setCompanyStatus } from '../../Store/Actions/Company';

import './styles.css';

export default function SideBar({ props }) {
  const state = useSelector(state => state.Company);
  const dispatch = useDispatch();

  useEffect(() => {
    if (isAuthenticated()) {
      dispatch(setIsLoading(true));
      async function loadCompany() {
        await api.get("/profile-company").then(res => {
          dispatch(setCompany(res.data));
          dispatch(setIsLoading(false));
          const rate = Math.floor(res.data.rate);
          for (var i = 0; i < rate; i++) {
            let paws = document.querySelectorAll(".svg-faw");
            paws[i].classList.add('faw-rating');
          }
        }).catch(error => {
          if((error.message === "Request failed with status code 401" || error.message === "Request failed with status code 500") && isAuthenticated()) {
            logout();
            props.history.push('/login');
          }
        });
      }
      loadCompany();
    } else {
      props.history.push('/login');
    }
  }, [dispatch, props.history, state.rate]);

  async function handleChangeStatus(e) {
    e.preventDefault();

    await api.put('/change-company-status').then(res => {
      if (state.data.status === 'Aberto') {
        dispatch(setCompanyStatus('Fechado'));
      } else {
        dispatch(setCompanyStatus('Aberto'));
      }
    });
  }

  const company = state.data;
  const isLoading = state.isLoading;

  return (
    <>
      <FixedBar />
      <aside id="sidebar-menu-left" className="sidebar">
        <div className="container-sidebar-left">
          <div className="information-company">
            <div className="information-company-area">
              <img src={company.avatar ? (company.avatar) : (PetShopDogLogo)} alt="Company Logo" />
            </div>
            {/* {isLoading ? (<Loading background="#1c1b20" />) : ( */}
              <div className="information-company-content">
                <div className="info-company-title">
                  {/* <h1>{company.companyName}</h1> */}
                  <h1>Demo company</h1>
                </div>
              <div className="info-company-paws">
                 <span>5 </span>
                  <PawLogo />
                  <PawLogo />
                  <PawLogo />
                  <PawLogo />
                  <PawLogo />
                  {/* <span>{company.rate === 5 ? ("5.0") : (company.rate)}</span> */}
                </div>
              </div>
            {/* )} */}
          </div>
          <div className="bottom-company-status">
            <div className="cart-set-status" role="button" onClick={e => handleChangeStatus(e)}>
              {/* <h3>{company.status}</h3> */}
              <h3>Online</h3>
            </div>
          </div>
          <div className="company-list-menu">
            <div className="transition">
              <h1>Home</h1>
              <div className="bar" />
            </div>
            <ul className="list-area">
              <a href="/dashboard"><li>Dashboard </li></a>
              <a href="/requests"><li>Requests</li></a>
              <a href="/services"><li>Services</li></a>
              <a href="/products"><li>Products</li></a>
              <a href="/assessments"><li>Assessments</li></a>
            </ul>
            <div className="transition">
              <h1>Registrations</h1>
              <div className="bar" />
            </div>
            <ul className="list-area">
              <a href="/register-service"><li>Register Service</li></a>
              <a href="/register-product"><li>Register Product</li></a>
              <a href="/settings"><li>Company information</li></a>
            </ul>
          </div>
        </div>
      </aside>
    </>
  );
}
