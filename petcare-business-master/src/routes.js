import React from 'react';

import { BrowserRouter, Switch, Route } from 'react-router-dom';
import { PrivateRoute } from './Components/PrivateRoute';

import CreateService from './Pages/CreateService';
import CreateProduct from './Pages/CreateProduct';
import EditPage from './Pages/EditPage';
import EditPageService from './Pages/EditPageService';

import ListProducts from './Pages/ListProducts';
import ListServices from './Pages/ListServices';
import ListRequests from './Pages/ListRequests';
import ListEvaluations from './Pages/ListEvaluations';

import Order from './Pages/Order';
import Preview from './Pages/Preview';
import Main from './Pages/Main';
import SettingsPage from './Pages/SettingsPage';

import SignUp from './Pages/SignUp';
import SignUpCompany from './Pages/SignUpCompany';
import SignUpOwner from './Pages/SignUpOwner';
import LogIn from './Pages/LogIn';

const Routes = () => (
  <BrowserRouter>
      <Switch>
          <Route exact path='/' component={Main} />
          <PrivateRoute path='/dashboard' component={Preview} />
          
          <Route path='/login' component={LogIn} />
          <Route path='/register' component={SignUp} />
          <Route path='/create-petshop' component={SignUpCompany} />
          <Route path='/finish ' component={SignUpOwner} />

          <PrivateRoute path='/register-service' component={CreateService} />
          <PrivateRoute path='/register-product' component={CreateProduct} />
          <PrivateRoute exact path='/products' component={ListProducts} />
          <PrivateRoute exact path='/services' component={ListServices} />
          <PrivateRoute exact path='/requests' component={ListRequests} />
          <PrivateRoute exact path='/assessments' component={ListEvaluations} />
          <PrivateRoute path='/settings' component={SettingsPage} />
          <PrivateRoute path='/requests/:id' component={Order} />
          <PrivateRoute path='/products/:id/edit' component={EditPage} />
          <PrivateRoute path='/services/:id/edit' component={EditPageService} />
          <Route path='*' component={Preview} />
      </Switch>
  </BrowserRouter>
);

export default Routes;