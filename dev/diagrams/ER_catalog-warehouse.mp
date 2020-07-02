input metauml;
outputformat := "png";
outputtemplate := "%j-%c.%o";
hppp := 0.5;
vppp := 0.5;

beginfig(1)
  Class.Container("Container")(
    "- items : Item[]",
    "- location : Coordinates",
    "- name : string",
    )();
  
  Class.Product("Product")(
    "- description : string",
    "- barcodes : Barcode[]",
    "- attachments: Attachment[]",
    "- featuredImageIndex : integer",
    "- details : string",
    "- specificationSheet : SpecificationSheet"
  )();
  
  Class.SpecificationSheet("SpecificationSheet")(
    "- type : 'Inventarium\Catalog\NetworkDevice'",
    "- id : number"
    )();
  
  Class.NetworkDeviceSpecificationSheet("NetworkDeviceSpecificationSheet")(
    "- vendor : string",
    "- model : string",
    "- firmware : string"
    )();
  
  Class.Tag("Tag")(
    "- name : string",
    "- pattern : SQLLikeExpr",
  )();
  
  Class.Barcode("Barcode")(
    "- tag : Tag",
    "- type: string",
    "- text: string"
    )();
    
  Class.Item("Item")(
    "- product : Product",
    "- barcodes : Barcode[]",
    "- note : string",
  )();
  
  Class.Attachment("Attachment")(
    "- mimeType : string",
    "- URI : string"
    )();
  
  Class.Transaction("Transaction")(
    "- item : Item",
    "- operation : 'Deposit' | 'Withdrawl' | 'Check' | 'Missing' ",
    "- reason : string",
    "- created_at : Date"
  )();
  
  
  Container.midx = Item.midx = Transaction.midx;
  Item.midy = Product.midy = Barcode.midy = Tag.midy;
  
  
  
  Container.s = Item.n + (0,10) ;
  Item.e = Product.w - (100,0);
  Item.s = Transaction.n + (0,10);
  Product.e = Barcode.w - (10,0);
  Barcode.e = Tag.w - (10,0);
  Product.n = Attachment.s - (0,10);
  Product.s = SpecificationSheet.n + (0,10);
  SpecificationSheet.s = NetworkDeviceSpecificationSheet.n + (0,10);
  
  
  
  drawObjects(
    Container,
    Item,
    Transaction,
    Product,
    SpecificationSheet,
    NetworkDeviceSpecificationSheet,
    Barcode,
    Tag,
    Attachment
  );
  
  
  clink(association)(Container, Item);
  clink(association)(Item, Transaction);
  clink(association)(Item, Product);
  clink(association)(Product, Barcode);
  clink(association)(Product, Attachment);
  clink(association)(Product, SpecificationSheet);
  clink(association)(SpecificationSheet, NetworkDeviceSpecificationSheet);

  clink(association)(Barcode, Tag);
  
  
  
endfig;

beginfig(2);
  Actor.user("User");
  Actor.db("Database");

  Usecase.dbquery("Query database");
  Usecase.auth("Authentification");
  Usecase.authA("Authentification by", "username, password");
  Usecase.authB("Authentification by", "smartcard");

  auth.w = user.human.e + (30,0);
  dbquery.s = auth.n + (0,30);
  db.human.w = dbquery.e + (30,0);

  authB.left - authA.right = 30;
  authB.midy = authA.midy;
  .5[authB.w, authA.e] = (auth.midx, auth.bottom - 50);
  
  drawObjects(user, auth, dbquery, db, authA, authB);

  clink(inheritance)(authA, auth);
  clink(inheritance)(authB, auth);
  clink(association)(auth, dbquery);
  clink(association)(user.human, auth);
  clink(association)(dbquery, db.human);
endfig;
end