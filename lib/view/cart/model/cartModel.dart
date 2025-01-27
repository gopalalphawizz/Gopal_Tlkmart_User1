// To parse this JSON data, do
//
//     final homeCartModel = homeCartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  bool status;
  String message;
  Data data;

  CartModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  dynamic deliveryType;
  String discountText;
  String totalItems;
  String subtotal;
  String discount;
  String mrp;
  String deliveryCharge;
  String tax;
  String total;
  List<CartProduct> products;
  String coupon_discount;

  Data(
      {required this.deliveryType,
      required this.discountText,
      required this.totalItems,
      required this.subtotal,
      required this.discount,
      required this.mrp,
      required this.deliveryCharge,
      required this.tax,
      required this.total,
      required this.products,
      required this.coupon_discount});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      deliveryType: json["delivery_type"],
      discountText: json["discount_text"],
      totalItems: json["total_items"],
      subtotal: json["subtotal"],
      discount: json["discount"],
      mrp: json["mrp"],
      deliveryCharge: json["delivery_charge"],
      tax: json["tax"],
      total: json["total"],
      products: List<CartProduct>.from(
          json["products"].map((x) => CartProduct.fromJson(x))),
      coupon_discount: json['coupon_discount'] ?? "");

  Map<String, dynamic> toJson() => {
        "delivery_type": deliveryType,
        "discount_text": discountText,
        "total_items": totalItems,
        "subtotal": subtotal,
        "discount": discount,
        "mrp": mrp,
        "delivery_charge": deliveryCharge,
        "tax": tax,
        "total": total,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "coupon_discount": coupon_discount
      };
}

class CartProduct {
  int id;
  List<CategoryId> categoryIds;
  int userId;
  Shop shop;
  String name;
  String slug;
  List<String> images;
  List<ColorImage> colorImage;
  String thumbnail;
  int brandId;
  String unit;
  int minQty;
  int featured;
  String refundable;
  int variantCartProduct;
  List<int> attributes;
  List<ChoiceOption> choiceOptions;
  List<Variation> variation;
  String weight;
  int published;
  String unitPrice;
  String specialPrice;
  String purchasePrice;
  int tax;
  String taxType;
  String taxModel;
  String taxAmount;
  int discount;
  String discountType;
  int currentStock;
  int minimumOrderQty;
  int freeShipping;
  String createdAt;
  String updatedAt;
  int status;
  int featuredStatus;
  String metaTitle;
  String metaDescription;
  String metaImage;
  int requestStatus;
  String shippingCost;
  int multiplyQty;
  String code;
  int reviewsCount;
  List<Rating> rating;
  List<Tag> tags;
  List<dynamic> translations;
  String shareLink;
  List<Review> reviews;
  List<ColorsFormatted> colorsFormatted;
  bool isFavorite;
  bool isCart;
  String cartId;
  String selectedQuantity;
  List<Choices> choices;
  List<Variations> variations;
  String variant;
  String color;

  CartProduct({
    required this.id,
    required this.categoryIds,
    required this.userId,
    required this.shop,
    required this.name,
    required this.slug,
    required this.images,
    required this.colorImage,
    required this.thumbnail,
    required this.brandId,
    required this.unit,
    required this.minQty,
    required this.featured,
    required this.refundable,
    required this.variantCartProduct,
    required this.attributes,
    required this.choiceOptions,
    required this.variation,
    required this.weight,
    required this.published,
    required this.unitPrice,
    required this.specialPrice,
    required this.purchasePrice,
    required this.tax,
    required this.taxType,
    required this.taxModel,
    required this.taxAmount,
    required this.discount,
    required this.discountType,
    required this.currentStock,
    required this.minimumOrderQty,
    required this.freeShipping,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.featuredStatus,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaImage,
    required this.requestStatus,
    required this.shippingCost,
    required this.multiplyQty,
    required this.code,
    required this.reviewsCount,
    required this.rating,
    required this.tags,
    required this.translations,
    required this.shareLink,
    required this.reviews,
    required this.colorsFormatted,
    required this.isFavorite,
    required this.isCart,
    required this.cartId,
    required this.selectedQuantity,
    required this.choices,
    required this.variations,
    required this.variant,
    required this.color,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json["id"],
        categoryIds: List<CategoryId>.from(
            json["category_ids"].map((x) => CategoryId.fromJson(x))),
        userId: json["user_id"],
        shop: Shop.fromJson(json["shop"]),
        name: json["name"],
        slug: json["slug"],
        images: List<String>.from(json["images"].map((x) => x)),
        colorImage: List<ColorImage>.from(
            json["color_image"].map((x) => ColorImage.fromJson(x))),
        thumbnail: json["thumbnail"],
        brandId: json["brand_id"],
        unit: json["unit"],
        minQty: json["min_qty"],
        featured: json["featured"],
        refundable: json["refundable"],
        variantCartProduct: json["variant_product"],
        attributes: List<int>.from(json["attributes"].map((x) => x)),
        choiceOptions: List<ChoiceOption>.from(
            json["choice_options"].map((x) => ChoiceOption.fromJson(x))),
        variation: List<Variation>.from(
            json["variation"].map((x) => Variation.fromJson(x))),
        weight: json["weight"],
        published: json["published"],
        unitPrice: json["unit_price"],
        specialPrice: json["special_price"],
        purchasePrice: json["purchase_price"],
        tax: json["tax"],
        taxType: json["tax_type"],
        taxModel: json["tax_model"],
        taxAmount: json["tax_amount"],
        discount: json["discount"],
        discountType: json["discount_type"],
        currentStock: json["current_stock"],
        minimumOrderQty: json["minimum_order_qty"],
        freeShipping: json["free_shipping"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        status: json["status"],
        featuredStatus: json["featured_status"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImage: json["meta_image"],
        requestStatus: json["request_status"],
        shippingCost: json["shipping_cost"],
        multiplyQty: json["multiply_qty"],
        code: json["code"],
        reviewsCount: json["reviews_count"],
        rating:
            List<Rating>.from(json["rating"].map((x) => Rating.fromJson(x))),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
        shareLink: json["share_link"],
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        colorsFormatted: List<ColorsFormatted>.from(
            json["colors_formatted"].map((x) => ColorsFormatted.fromJson(x))),
        isFavorite: json["is_favorite"],
        isCart: json["is_cart"],
        cartId: json["cart_id"],
        selectedQuantity: json["selected_quantity"],
        choices:
            List<Choices>.from(json["choices"].map((x) => Choices.fromJson(x))),
        variations: List<Variations>.from(
            json["variations"].map((x) => Variations.fromJson(x))),
        variant: json["variant"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_ids": List<dynamic>.from(categoryIds.map((x) => x.toJson())),
        "user_id": userId,
        "shop": shop.toJson(),
        "name": name,
        "slug": slug,
        "images": List<dynamic>.from(images.map((x) => x)),
        "color_image": List<dynamic>.from(colorImage.map((x) => x.toJson())),
        "thumbnail": thumbnail,
        "brand_id": brandId,
        "unit": unit,
        "min_qty": minQty,
        "featured": featured,
        "refundable": refundable,
        "variant_product": variantCartProduct,
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "choice_options":
            List<dynamic>.from(choiceOptions.map((x) => x.toJson())),
        "variation": List<dynamic>.from(variation.map((x) => x.toJson())),
        "weight": weight,
        "published": published,
        "unit_price": unitPrice,
        "special_price": specialPrice,
        "purchase_price": purchasePrice,
        "tax": tax,
        "tax_type": taxType,
        "tax_model": taxModel,
        "tax_amount": taxAmount,
        "discount": discount,
        "discount_type": discountType,
        "current_stock": currentStock,
        "minimum_order_qty": minimumOrderQty,
        "free_shipping": freeShipping,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "status": status,
        "featured_status": featuredStatus,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_image": metaImage,
        "request_status": requestStatus,
        "shipping_cost": shippingCost,
        "multiply_qty": multiplyQty,
        "code": code,
        "reviews_count": reviewsCount,
        "rating": List<dynamic>.from(rating.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "translations": List<dynamic>.from(translations.map((x) => x)),
        "share_link": shareLink,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "colors_formatted":
            List<dynamic>.from(colorsFormatted.map((x) => x.toJson())),
        "is_favorite": isFavorite,
        "is_cart": isCart,
        "cart_id": cartId,
        "selected_quantity": selectedQuantity,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
        "variant": variant,
        "color": color,
      };
}

class CategoryId {
  String id;
  int position;

  CategoryId({
    required this.id,
    required this.position,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
      };
}

class ChoiceOption {
  String name;
  String title;
  List<String> options;

  ChoiceOption({
    required this.name,
    required this.title,
    required this.options,
  });

  factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
        name: json["name"],
        title: json["title"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}

class Choices {
  dynamic choice2;

  Choices({
    required this.choice2,
  });

  factory Choices.fromJson(Map<String, dynamic> json) => Choices(
        choice2: json["choice_2"],
      );

  Map<String, dynamic> toJson() => {
        "choice_2": choice2,
      };
}

class ColorImage {
  String color;
  String imageName;

  ColorImage({
    required this.color,
    required this.imageName,
  });

  factory ColorImage.fromJson(Map<String, dynamic> json) => ColorImage(
        color: json["color"],
        imageName: json["image_name"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "image_name": imageName,
      };
}

class ColorsFormatted {
  String name;
  String code;

  ColorsFormatted({
    required this.name,
    required this.code,
  });

  factory ColorsFormatted.fromJson(Map<String, dynamic> json) =>
      ColorsFormatted(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
      };
}

class Rating {
  String average;
  int productId;

  Rating({
    required this.average,
    required this.productId,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        average: json["average"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "average": average,
        "product_id": productId,
      };
}

class Review {
  int id;
  int productId;
  int customerId;
  String deliveryManId;
  String orderId;
  String comment;
  List<String> attachment;
  int rating;
  int status;
  int isSaved;
  String createdAt;
  String updatedAt;
  Customer customer;

  Review({
    required this.id,
    required this.productId,
    required this.customerId,
    required this.deliveryManId,
    required this.orderId,
    required this.comment,
    required this.attachment,
    required this.rating,
    required this.status,
    required this.isSaved,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        productId: json["product_id"],
        customerId: json["customer_id"],
        deliveryManId: json["delivery_man_id"],
        orderId: json["order_id"],
        comment: json["comment"],
        attachment: List<String>.from(json["attachment"].map((x) => x)),
        rating: json["rating"],
        status: json["status"],
        isSaved: json["is_saved"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        customer: Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "customer_id": customerId,
        "delivery_man_id": deliveryManId,
        "order_id": orderId,
        "comment": comment,
        "attachment": List<dynamic>.from(attachment.map((x) => x)),
        "rating": rating,
        "status": status,
        "is_saved": isSaved,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "customer": customer.toJson(),
      };
}

class Customer {
  int id;
  String name;
  String image;

  Customer({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

class Shop {
  String id;
  String sellerId;
  String name;
  String address;
  String contact;
  String image;
  String bottomBanner;
  String vacationStartDate;
  String vacationEndDate;
  String vacationNote;
  int vacationStatus;
  int temporaryClose;
  String createdAt;
  String updatedAt;
  String rating;
  String followers;
  String isVerified;
  String isFollowing;
  String banner;

  Shop({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.address,
    required this.contact,
    required this.image,
    required this.bottomBanner,
    required this.vacationStartDate,
    required this.vacationEndDate,
    required this.vacationNote,
    required this.vacationStatus,
    required this.temporaryClose,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.followers,
    required this.isVerified,
    required this.isFollowing,
    required this.banner,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        sellerId: json["seller_id"],
        name: json["name"],
        address: json["address"],
        contact: json["contact"],
        image: json["image"],
        bottomBanner: json["bottom_banner"],
        vacationStartDate: json["vacation_start_date"],
        vacationEndDate: json["vacation_end_date"],
        vacationNote: json["vacation_note"],
        vacationStatus: json["vacation_status"],
        temporaryClose: json["temporary_close"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        rating: json["rating"],
        followers: json["followers"],
        isVerified: json["is_verified"],
        isFollowing: json["is_following"],
        banner: json["banner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "name": name,
        "address": address,
        "contact": contact,
        "image": image,
        "bottom_banner": bottomBanner,
        "vacation_start_date": vacationStartDate,
        "vacation_end_date": vacationEndDate,
        "vacation_note": vacationNote,
        "vacation_status": vacationStatus,
        "temporary_close": temporaryClose,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "rating": rating,
        "followers": followers,
        "is_verified": isVerified,
        "is_following": isFollowing,
        "banner": banner,
      };
}

class Tag {
  int id;
  String tag;
  int visitCount;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  Tag({
    required this.id,
    required this.tag,
    required this.visitCount,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        tag: json["tag"],
        visitCount: json["visit_count"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
        "visit_count": visitCount,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  int productId;
  int tagId;

  Pivot({
    required this.productId,
    required this.tagId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        productId: json["product_id"],
        tagId: json["tag_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "tag_id": tagId,
      };
}

class Variation {
  String type;
  String price;
  String sku;
  int qty;

  Variation({
    required this.type,
    required this.price,
    required this.sku,
    required this.qty,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        type: json["type"],
        price: json["price"],
        sku: json["sku"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "price": price,
        "sku": sku,
        "qty": qty,
      };
}

class Variations {
  dynamic size;

  Variations({
    required this.size,
  });

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
        size: json["Size"],
      );

  Map<String, dynamic> toJson() => {
        "Size": size,
      };
}
