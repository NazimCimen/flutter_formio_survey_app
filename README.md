# 🌟 FORMIO - Anket Uygulaması (Devam Ediyor)      

![Uygulama Tanıtım](https://github.com/NazimCimen/flutter_formio_survey_app/blob/main/assets/readme_img2.png)  
![Uygulama Tanıtım](https://github.com/NazimCimen/flutter_formio_survey_app/blob/main/assets/readme2.png)  


Bu uygulama, kullanıcıların çeşitli soru tiplerini seçerek kendi anketlerini kolayca oluşturmasına olanak tanır. Kullanıcılar, oluşturdukları anketlerin bağlantısını paylaşarak başkalarının anonim olarak yanıtlamasını sağlayabilir.  
**Gelecek Güncellemeler**:  
- Web platformunda anket yanıtlama.  
- Anket yanıtlarını analiz etme.  
- Daha detaylı raporlama.  

![Version](https://img.shields.io/badge/version-1.0.0-blue)  ![Flutter](https://img.shields.io/badge/Flutter-v3.22.0-blue)


# 🛠️ Proje Özellikleri

| **Özellik**                     | **Açıklama**                                                                                     |
|----------------------------------|-------------------------------------------------------------------------------------------------|
| 🌟 **Clean Architecture**        | Temiz ve sürdürülebilir kod yapısı Clean Architecture prensiplerine uygun olarak oluşturuldu.  |
| 🖼️ **MVVM Tasarım Deseni**       | Kod okunabilirliği ve yönetilebilirliği ön planda tutularak MVVM tasarım deseniyle geliştirildi|
| 🌿 **Branch Yönetimi**           | Main, Development ve Feature branch'lerle organize bir geliştirme süreci sağlandı.             |
| 🚀 **CI Süreci**                 | GitHub Actions ile otomatik test ve Continuous Integration (CI) süreçleri yapılandırıldı.      |
| 🔑 **GitHub Secrets**            | Firebase otomasyonu için `firebase_options.dart` dosyası CI sırasında otomatik oluşturuluyor.  |
| ✅ **Unit Testler**              | Kod güvenilirliği ve hataları minimize etmek için  unit testler yazıldı.                       |
| 🛠️ **Dependency Injection**      | `GetIt` kütüphanesiyle bağımlılık yönetimi daha test edilebilir hale getirildi.                |
| 🔥 **Firebase Entegrasyonu**     | Firestore ve Storage ile güvenli veri saklama ve medya yönetimi gerçekleştirildi.              |
| ⛑️ **Force Update Özelliği**     | Eski sürümlerin kullanılmasını önlemek için zorunlu güncelleme mekanizması eklendi.            |
| 🎨 **Tema Desteği**              | Koyu ve açık mod ile modern ve kullanıcı dostu bir tema tasarlandı.                            |
| 🌍 **Çoklu Dil Desteği**         | 11 farklı dil desteğiyle global bir kullanıcı kitlesine hitap edecek şekilde yapılandırıldı.   |
| 🔍 **Kod Standartı**             | `very_good_analysis` linter kullanılarak kod kalitesi ve standartlara uygunluk sağlandı.       |




## 🌿 **Branch Yönetim**i  
- **Main Branch**: Son ve kararlı uygulama sürümü.  
- **Development Branch**: Aktif geliştirme süreçleri.  
- **Feature Branch**: Yeni özellikler için `f-feature_name` formatı.  

### Geliştirme Süreci:  
1. Yeni özellikler feature branch'lerde geliştirildi.  
2. Tamamlanan özellikler **development** branch'ine merge edildi.  
3. Testler başarılıysa, **main** branch'e aktarıldı.  

## 🚀 **CI Süreci ve GitHub Secrets Kullanımı**
- **GitHub Actions**: Continuous Integration (CI) süreci, geliştirme aşamalarında kodun güvenliğini ve kalitesini sağlamak için yapılandırıldı.  
- **Testlerin Çalıştırılması**: `ci.yaml` dosyası ile her `development` branch'ine yapılan pull request (PR) işlemleri sırasında otomatik olarak testler çalıştırılmaktadır. Bu sayede, yeni kod değişikliklerinin mevcut kod ile uyumluluğu ve fonksiyonel doğruluğu sürekli olarak kontrol edilmektedir.  
- **Firebase Otomasyonu**: `firebase_options.dart` dosyası, GitHub Secrets kullanılarak CI sırasında otomatik oluşturuluyor.  

## 📂 **Proje Klasör Yapısı**  

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
## 📦 Kurulum

1. Depoyu klonlayın:
    ```sh
    git clone https://github.com/yourusername/your-repo.git
    cd your-repo
    ```

2. Bağımlılıkları yükleyin:
    ```sh
    flutter pub get
    ```

3. Firebase'i ayarlayın:
    - Firebase'i Flutter projenize eklemek için talimatları izleyin: [Firebase Setup](https://firebase.flutter.dev/docs/overview)
    - `google-services.json` ve `GoogleService-Info.plist` dosyalarını ilgili dizinlere yerleştirin.

## 🚀 Kullanım

1. Uygulamayı çalıştırın:
    ```sh
    flutter run
    ```
