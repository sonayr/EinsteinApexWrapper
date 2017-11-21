({

  onCreateDataset : function(component, event, helper) {

      helper.onCreateDataset(component);

  },

  onLoadDatasets : function(component, event, helper) {

      helper.onLoadDatasets(component);

  },

  onTrainDataset : function(component, event, helper) {

      helper.onTrainDataset(component, event);

  },

  onDeleteDataset : function(component, event, helper) {

      helper.onDeleteDataset(component, event);

  },

  onReadImage: function(component, event, helper) {
      var files = component.get("v.files");
      if (files && files.length > 0) {
          var file = files[0][0];
          console.log(file.type);
          if (!file.type.match('application/vnd.ms-excel')) {
              return alert('Only Csv files accepted');
          }
          var reader = new FileReader();
          reader.onloadend = function() {
              var dataURL = reader.result;
              console.log(dataURL);
              console.log(dataURL.match(/,(.*)$/)[1]);
              component.set('v.csvURL',dataURL.match(/,(.*)$/)[1]);
              helper.onCreateDataset(component);
          };
          reader.readAsDataURL(file);
      }   
  }

})