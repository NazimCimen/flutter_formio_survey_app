## FORMIO - ANKET UYGULAMASI (DEVAM EDİYOR)

![Uygulama Logosu](https://firebasestorage.googleapis.com/v0/b/formio-90f75.appspot.com/o/Add%20a%20heading%20(1).png?alt=media&token=0860b04b-a6bf-40b4-add2-d7b9ddbbd1a1)
  <b>Bu uygulama, kullanıcıların çeşitli soru tiplerini seçerek kendi anketlerini kolayca oluşturmasına olanak tanır. Kullanıcılar, oluşturdukları anketlerin bağlantısını paylaşarak başkalarının anonim olarak yanıtlamasını sağlayabilir. Gelecekteki güncellemelerle,web platformu dahil olmak üzere anket yanıtlama, anket yanıtlarını analiz etme ve daha detaylı raporlama özellikleri de projeye eklenecektir.
</p>


## 🛠️ Proje Özellikleri  

### 🏗️ Clean Architecture  
- **Temiz ve Sürdürülebilir Kod**: Clean Architecture prensiplerine uygun olarak yapılandırıldı.  
 
### 🖼️ MVVM Tasarım Deseni  
- Uygulama, **Model-View-ViewModel (MVVM)** tasarım deseni ile geliştirildi. Kod okunabilirliği ve yönetilebilirlik ön planda tutuldu.  

### 🌿 Branch Yönetimi  
- **Main Branch**: Son ve kararlı uygulama sürümü.  
- **Development Branch**: Aktif geliştirme süreçleri.  
- **Feature Branch**: Yeni özellikler için `f-feature_name` formatı.  

#### Geliştirme Süreci:  
1. Yeni özellikler feature branch'lerde geliştirildi.  
2. Tamamlanan özellikler **development** branch'ine merge edildi.  
3. Testler başarılıysa, **main** branch'e aktarıldı.  

### ✅ Unit Testler  
- Kod güvenilirliğini artırmak ve hataları minimize etmek için kapsamlı unit testler yazıldı.  

### 🛠️ Dependency Injection  
- **GetIt**: Bağımlılık yönetimi için `GetIt` kütüphanesi kullanıldı. Kodun daha yönetilebilir ve test edilebilir olması sağlandı.  

### 🚀 CI Süreci
- **GitHub Actions**: Continuous Integration (CI) süreci, geliştirme aşamalarında kodun güvenliğini ve kalitesini sağlamak için yapılandırıldı.  
- **Testlerin Çalıştırılması**: `ci.yaml` dosyası ile her `development` branch'ine yapılan pull request (PR) işlemleri sırasında otomatik olarak testler çalıştırılmaktadır. Bu sayede, yeni kod değişikliklerinin mevcut kod ile uyumluluğu ve fonksiyonel doğruluğu sürekli olarak kontrol edilmektedir.  

### 🔑 GitHub Secrets  
- **Firebase Otomasyonu**: `firebase_options.dart` dosyası, GitHub Secrets kullanılarak CI sırasında otomatik oluşturuluyor.  

### 🔥 Firebase Entegrasyonu  
- **Firestore**: Veritabanı işlemleri Firebase Firestore ile gerçekleştirildi.  
- **Storage**: Medya dosyalarının güvenli ve hızlı bir şekilde saklanması için Firebase Storage kullanıldı.

### ⛑️ Force Update Özelliği  
- Eski uygulama sürümlerinin kullanılmasını önlemek için **Force Update** özelliği eklendi.  

### 🎨 Tema Desteği  
- Modern ve kullanıcı dostu bir tema tasarımı ile uygulama estetik ve işlevsel hale getirildi.  
- **Dark ve Light Mod**: Uygulama, kullanıcı tercihine göre koyu ve açık tema desteği sunmaktadır.  

### 🌍 Çoklu Dil Desteği  
- 11 farklı dilde localization desteği eklendi.Uygulama Global kullanıcı kitlesine hitap edecek şekilde geliştirildi.  

### 🔍 Kod Standartı  
- **very_good_analysis** linter kural seti ile kod kalitesi ve standartlara uygunluk sağlandı.  

## 📂 Proje Klasör Yapısı  

Proje, Clean Architecture prensiplerine uygun olarak yapılandırılmıştır. Klasörlerin işlevleri şu şekilde açıklanabilir:  

```plaintext
lib/
├── config/                 # Uygulama yapılandırmaları
│   ├── localization/       # Çoklu dil desteği için ayarlar
│   ├── routes/             # Uygulama navigasyon rotaları
│   ├── theme/              # Tema yönetimi ve Dark ve Light mod temaları
├── core/                   # Uygulamanın temel yapı taşları
│   ├── app/                # Uygulama sürüm kontrolü
│   ├── base/               # Widget'ler için ortak temel yapılar
│   ├── cache/              # Veri saklama modülleri
│   ├── connection/         # İnternet bağlantı kontrolü
│   ├── error/              # Hata yönetimi ve özel hata sınıfları
│   ├── init/               # Başlatma işlemleri
│   ├── utils/              # Genel yardımcı araçlar
├── dependency_injection/   # Bağımlılık yönetimi
├── feature/                # Uygulamanın ana özellikleri
│   ├── create_survey/      # Anket oluşturma özelliği
│   ├── home/               # Ana sayfa işlevselliği
│   ├── image_process/      # Görsel seçme ve kırpma işlemleri 
│   ├── settings/           # Kullanıcı ayarları modülü
│   ├── shared_layers/      # Ortak kullanılan katmanlar
│   ├── splash/             # Açılış ekranı
├── product/                # Genel kullanılan bileşenler ve yardımcı araçlar
│   ├── components/         # Küçük UI bileşenleri
│   ├── constants/          # Uygulama genelindeki sabitler
│   ├── decorations/        # Stil ve dekorasyon öğeleri
│   ├── firebase/           # Firebase entegrasyonu
│   ├── helper/             # Yardımcı sınıflar ve araçlar
│   ├── widgets/            # Temel Widgetlar
└── main.dart               # Uygulamanın başlangıç noktası
```

## KULLANILAN PAKETLER
- Core
  * [provider](https://pub.dev/packages/provider)
  * [mockito](https://pub.dev/packages/mockito)
  * [dartz](https://pub.dev/packages/dartz)
  * [get_it](https://pub.dev/packages/get_it)
  * [uuid](https://pub.dev/packages/uuid)
  * [package_info_plus](https://pub.dev/packages/package_info_plus)
  * [internet_connection_checker](https://pub.dev/packages/internet_connection_checker)
  * [json_annotation](https://pub.dev/packages/json_annotation)
  * [equatable](https://pub.dev/packages/equatable)
    
- Config
  * [easy_localization](https://pub.dev/packages/easy_localization)
  * [intl](https://pub.dev/packages/intl)
    
- Utils
  * [share_plus](https://pub.dev/packages/share_plus)
  * [url_launcher](https://pub.dev/packages/url_launcher)
  * [change_app_package_name](https://pub.dev/packages/change_app_package_name)
  * [image_cropper](https://pub.dev/packages/image_cropper)
  * [image_picker](https://pub.dev/packages/image_picker)
    
- Firebase
  * [firebase_core](https://pub.dev/packages/firebase_core)
  * [cloud_firestore](https://pub.dev/packages/cloud_firestore)
  * [firebase_storage](https://pub.dev/packages/firebase_storage)
    
- Cache
  * [shared_preferences](https://pub.dev/packages/shared_preferences)
  * [hive](https://pub.dev/packages/hive)
  * [hive_flutter](https://pub.dev/packages/hive_flutter)
  * [encrypt](https://pub.dev/packages/encrypt)
  * [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
    
- Ui
  * [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter)
  * [cupertino_icons](https://pub.dev/packages/cupertino_icons)
  * [google_fonts](https://pub.dev/packages/google_fonts)
  * [flutter_speed_dial](https://pub.dev/packages/flutter_speed_dial)
    
- Dev_dependencies
  * [build_runner](https://pub.dev/packages/build_runner)
  * [json_serializable](https://pub.dev/packages/json_serializable)
  * [very_good_analysis](https://pub.dev/packages/very_good_analysis)
  * [hive_generator](https://pub.dev/packages/hive_generator)
