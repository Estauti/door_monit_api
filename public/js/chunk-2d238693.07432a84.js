(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2d238693"],{feec:function(e,t,n){"use strict";n.r(t);var s=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",[n("h1",[e._v("Medições")]),n("b-table",{staticClass:"mt-4",attrs:{striped:"",hover:"",items:e.measurements,fields:e.measurements_fields},scopedSlots:e._u([{key:"cell(opened)",fn:function(e){return[n("font-awesome-icon",{attrs:{icon:e.value?"door-open":"door-closed",size:"lg"}})]}},{key:"cell(created_at)",fn:function(t){return[e._v(" "+e._s(e.$moment(t.value).format("DD/MM/YYYY HH:mm:ss"))+" ")]}}])})],1)},a=[],o=n("bc3a"),c=n.n(o),r=n("6221"),i={data:function(){return{measurements_fields:[{key:"opened",label:"Status"},{key:"device_name",label:"Dispositivo"},{key:"created_at",label:"Data Criação"}],measurements:[]}},created:function(){this.getMeasurements()},methods:{getMeasurements:function(){var e=this;c.a.get("".concat(r["a"],"/api/measurements.json")).then((function(t){e.measurements=t.data})).catch((function(e){console.log(e)}))}}},u=i,l=n("2877"),m=Object(l["a"])(u,s,a,!1,null,null,null);t["default"]=m.exports}}]);
//# sourceMappingURL=chunk-2d238693.07432a84.js.map