namespace x_renegotiation.ext; // only applies to new entities defined below

using {
  NegotiationService,
  com.sap.procrenegotiation.NegotiationProjectItem,
  com.sap.procrenegotiation.NegotiationProjectHeader
} from 'renegotiation-srv';

extend NegotiationProjectHeader with {
  x_new_field_ext : String;
  x_mydate_ext : Date;
  x_dummy : Integer @Measures.Unit : targetSavingPercentageUnit;
};

extend NegotiationProjectItem with {
  x_quotation_ext : String @readonly;
  x_quantity_ext : String ;
};

// -------------------------------------------
// Fiori Annotations

annotate NegotiationProjectHeader : x_new_field_ext with @title: 'New Field EXT';
annotate NegotiationProjectItem : x_quotation_ext with @title: 'Quotation EXT';
annotate NegotiationProjectHeader : x_mydate_ext with @title: 'Current Date EXT';
annotate NegotiationProjectItem : x_quantity_ext with @title : 'Quantity EXT';
annotate NegotiationProjectHeader : x_dummy with @title: 'Dummy EXT';

annotate NegotiationService.NegotiationProjectHeaders with @(UI: {
  HeaderFacets  : [...,{
      $Type  : 'UI.ReferenceFacet',
      ID     : 'ProjectImprovementChart3',
      Target : '@UI.Chart#ProjectImprovementChart3'
    }],
  FieldGroup #GeneralInformationData1: {Data: [...,{
    Value: x_mydate_ext,
    Label: 'Current Date EXT' 
  },
  {
    Value: x_new_field_ext,
    Label: 'New Field EXT'
  },
  {
    Value: x_dummy,
    Label: 'Dummy EXT'
  }]},
  Chart #ProjectImprovementChart3 : {
    $Type : 'UI.ChartDefinitionType',
    Title : 'Product Width Specification',
    Description : 'New Chart extended',
    ChartType : #Bullet,
    Measures : [
        x_dummy
    ],
    MeasureAttributes : [
        {
            $Type : 'UI.ChartMeasureAttributeType',
            Measure : x_dummy,
            Role : #Axis1,
            DataPoint : '@UI.DataPoint#Dummy'
        }
    ]
},
DataPoint #Dummy : {
    Value : x_dummy,
    Title : 'Dummy Chart',
    TargetValue: 50,
    ForecastValue: 30,
    Description : 'Column Micro Chart',
    MinimumValue : 10,
    MaximumValue : 100
}
});

annotate NegotiationService.NegotiationProjectItems with @(UI: {
  FieldGroup #GeneralInformationItemData: {Data: [...,{
    Value: x_quotation_ext,
    Label: 'Quotation EXT'
  },
  {
    Value: x_quantity_ext,
    Label: 'Quantity EXT'
  }]},
});

