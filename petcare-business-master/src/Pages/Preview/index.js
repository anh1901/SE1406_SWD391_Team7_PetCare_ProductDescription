import React, { useEffect, useState } from 'react';

import SideBar from '../../Components/SideBar';
import Loading from '../../Components/Loading';
import FavoriteButton from '../../Components/FavoriteButton';
import AddressInfo from '../../Components/AddressInfo';
import StatusInfo from '../../Components/StatusInfo';
import ServiceCardToUser from '../../Components/ServiceCardToUser';
import ProductCard from '../../Components/ProductCard';
import BottomLoadMore from '../../Components/BottomLoadMore';

import PawLogo from '../../Assets/PawLogo';
import PetShopDogLogo from '../../Assets/PetShopDogLogo.svg';

import { useSelector } from 'react-redux';

import api from '../../Services/api';

import './styles.css';

export default function Preview(props) {
  const state = useSelector(state => state.Company);
  
  // LIST
  const [products, setProducts] = useState([]);
  const [services, setServices] = useState([]);
  
  // PAGES SERVICES 
  const [actPageService, setActPageService] = useState(0);
  const [totalPagesService, setTotalPagesService] = useState(0);
  const [isLoadingService, setIsLoadingService] = useState(false);

  // PAGES PRODUCTS 
  const [actPageProduct, setActPageProduct] = useState(0);
  const [totalPagesProduct, setTotalPagesProduct] = useState(0);
  const [isLoadingProduct, setIsLoadingProduct] = useState(false);

  async function loadServices(page) {
    setIsLoadingService(true);
    setServices([
          {
              id: '1',
              name: "Grooming",
              description: "Get the hair.",
              price:120000,
          },
          {
              id: '1',
              name: "Bathing",
              description: "Bath your pet",
              price:30000,
          }
      ]);
      setTotalPagesService(1);
      setIsLoadingService(false)
      if (totalPagesService <= 1) {
        let btn = document.querySelector(".btn-loadServices");
        if (btn !== null) {
          btn.classList.add("button-load-more-no-content");
        }
      }
    // await api.get(`/services/${page}`).then(res => {
    //   setServices(res.data.content);
    //   setTotalPagesService(res.data.totalPages);
    //   setIsLoadingService(false)
    //   if (res.data.totalPages <= 1) {
    //     let btn = document.querySelector(".btn-loadServices");
    //     if (btn !== null) {
    //       btn.classList.add("button-load-more-no-content");
    //     }
    //   }
    // });
  }

  async function loadProducts(page) {
    setIsLoadingProduct(true);
    // await api.get(`/products/${page}`).then(res => {
    //   setProducts(res.data.content);
    //   setTotalPagesProduct(res.data.totalPages);
    //   setIsLoadingProduct(false);
    //   if (res.data.totalPages <= 1) {
    //     let btn = document.querySelector(".btn-loadProducts");
    //     if (btn !== null) {
    //       btn.classList.add("button-load-more-no-content");
    //     }
    //   }
    // });
  }

  useEffect(() => {
    if (!state.isLoading) {
      const rate = Math.floor(state.data.rate);
      for (var i = 0; i < rate; i++) {
        let paws = document.querySelectorAll(".paw-preview");
        paws[i].classList.add('faw-rating');
      }
    }
    loadServices(0);
    loadProducts(0);
  }, [state.data.rate, state.isLoading])

  async function handleLoadMoreServices(page) {
    if (totalPagesService > page) {
      await api.get(`/services/${page}`).then(res => {
        setServices(services.concat(res.data.content));
        setActPageService(page);
      });
    } else {
      let btn = document.querySelector(".btn-loadServices");
      btn.classList.add("button-load-more-no-content");
    }
  }

  async function handleLoadMoreProducts(page) {
    if (totalPagesProduct > page) {
      await api.get(`/products/${page}`).then(res => {
        setProducts(products.concat(res.data.content));
        setActPageProduct(page);
      });
    } else {
      let btn = document.querySelector(".btn-loadProducts");
      btn.classList.add("button-load-more-no-content");
    }
  }

  const company = state.data;
  const isLoading = state.isLoading;

  return (
    <>
      <SideBar props={props} />
      <div className="container-page-sidebar">
        <div className="box-color-area" />
        <div className="content-preview">
          <div className="buttons-actions">
            <div className="actions">
              <FavoriteButton favorite={false} />
              <div className="report button-design" role="button">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="square" strokeLinejoin="arcs"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12" y2="16"></line></svg>
                <button>Report</button>
              </div>
            </div>
          </div>
          <div className="box-main-information">
            <div className="img-area">
              <img src={company.avatar ? (company.avatar) : (PetShopDogLogo)} alt="Company Logo" />
            </div>
            <div className="title-joinedDate">
              {/* {isLoading ? (<Loading />) : ( */}
                <>
                {/* <h1>{company.companyName}</h1> */}
                <h1>Demo company</h1>
                <div className="evaluation-paws-preview">
                  <span>5 </span>
                    <PawLogo className="paw-preview" />
                    <PawLogo className="paw-preview" />
                    <PawLogo className="paw-preview" />
                    <PawLogo className="paw-preview" />
                    <PawLogo className="paw-preview" />
                    {/* <span>{company.rate === 5 ? ("5.0") : (company.rate)}</span> */}
                  </div>
                </>
              {/* )} */}
            </div>
            <div className="transion-small" />
            <div className="address-status">
              <div className="address-area">
                <h3>Address</h3>
                {/* {isLoading ? (<Loading boxShadow="none" />) : (company.address ? <AddressInfo key={company.address.id} text={company.address.street + ', ' + company.address.placeNumber + (company.address.complement ? (', ' + company.address.complement + ' - ') : (' - ')) + company.address.neighborhood + ', ' + company.address.city + ' - ' + company.address.state + ', ' + company.address.cep} /> : (<AddressInfo text="Esta empresa não possui nenhum endereço." />))} */}
                 <AddressInfo key="001" text={"342/121B" + ', ' + "Le Loi" +  "Hoc Mon" + ', ' + "TP.HCM" + ' - ' + "Viet Nam"+'.'} />
              </div>
              <div className="status-area">
                <h3>Schedule</h3>
                {/* {isLoading ? (<Loading boxShadow="none" />) : (<StatusInfo text={company.status} />)} */}
                <StatusInfo text="Online" />
              </div>
            </div>
            {/* {company.description ? ( */}
              <>
                <div className="description-area-company-profile">
                  <div className="content-description-company-profile">
                    <div className="title-description-company">
                      <h3>Description</h3>
                    </div>
                  {/* <p>{company.description}</p> */}
                  <p>A pet shop or pet store is a retail business which sells different kinds of animals to the public. A variety of animal supplies and pet accessories are also sold in pet shops. The products sold include: food, treats, toys, collars, leashes, cat litter, cages and aquariums.</p>
                  </div>
                </div>
              </>
            {/* ) : ('')} */}
          </div>
        </div>
        <div className="content-company">
          <div className="products-area">
            <div className="title-area">
              <h3>Services</h3>
            </div>
            <div className="transion-small" />
            {isLoadingService ? (<Loading />) : (
              <>
                <div className="grid-services">
                  {services.map(service => <ServiceCardToUser key={service.id} service={service} />)}
                </div>
                <BottomLoadMore setClassName="btn-loadServices" text="Load more products" onClick={() => handleLoadMoreServices(actPageService + 1)} />
              </>
            )}
            <div className="title-area">
              <h3>Products</h3>
            </div>
            <div className="transion-small" />
            {/* {isLoadingProduct ? (<Loading />) : (
              <>
                <div className="grid-products">
                  {products.map(product => <ProductCard key={product.id} product={product} />)}
                </div>
                <BottomLoadMore setClassName="btn-loadProducts" text="Load more products" onClick={() => handleLoadMoreProducts(actPageProduct + 1)} />
              </>
            )} */}
            <div className="grid-products">
              <p>Not develope yet.</p>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
