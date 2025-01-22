# Reactive Programlama

Temel olarak ne yapacağını söylemez, nasıl yapacağını söyler.

### **Imperative ve declarative programlama**

-   Imperatif programlamada, programı adım adım yönlendirirsiniz. Yani, ne yapılacağını ve nasıl yapılacağını açıkça belirtirsiniz. Örnek: Veriyi yükle, veriyi manipüle et, veriyi görselleştir.

-   Deklaratif programlamada ise ne yapılacağını genel hatlarıyla söylersiniz, ama bunu nasıl ve ne zaman yapılacağını başka bir sistem belirler.

Özetle, imperative programlamada "bana bir sandviç yap", deklarifte "dolabı açtığımda, dolapta bir sandviç olduğunu garanti et" şeklinde çalışır.

1- Reaktif ifadeler ilk çalıştırıldığı ana kadar bir değer tutmaz. İlk çalıştırmadan sonra bu değeri saklar. Eğer "nasıl yapacağı" ile ilgili talimatlar değişmediyse herhangi bir işlem yapmaz.

`a <- reactive( 5 + 4 ) ; a()`

Burada a reaktif ifadesi çağırıldıktan sonra tekrar işlem yapmaz.

Ancak reactive ifadelerin bağımlı olduğu bir durum değişirse bu ifade de tekrar hesaplanır. Tekrar hesaplandığı için bu ifadeye bağlı diğer reaktifler de tetiklenir.

2- Reaktif ifadeler eğer gerek yoksa çalışmaz.

### Observe

herhangi bir reaktif bağımlılığı değiştiğinde hemen çalıştırılır hatta bu ifadenin çıktısı bağımlıları tarafından kullanılmasa bile.

### Sık yapılan hatalar:

-   observe ve observeEvent ile atama

```{=html}
<!-- -->
```
-   render fonksiyonunu, observe ya da observeEvent içerisine koyma.

-   iç içe observe kullanmaktan kaçın.

Kaynak:

Mastering Shiny - Basic reactivity

<https://stackoverflow.com/questions/39436713/r-shiny-reactivevalues-vs-reactive> [*Josh O'Brien*](https://stackoverflow.com/users/980833/josh-obrien) *ve [DeanAttali](https://stackoverflow.com/users/3943160/deanattali) cevapları.*
