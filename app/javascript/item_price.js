window.addEventListener('turbo:load', () => {
  //ページが読み込まれたら以下の関数を実行するようイベントリスナーリスナーを実装
  const priceInput = document.getElementById("item-price");
  //item-priceというidを持つ入力フィールドを習得し、priceInputという変数に格納
  const feeOutput = document.getElementById("add-tax-price");
  //add-tax-priceというidを持つ入力フィールドを習得し、priceInputという変数に格納
  const profitOutput = document.getElementById("profit");
  //profitというidを持つ入力フィールドを習得し、priceInputという変数に格納

  if (priceInput) {
    //priceInputが存在していれば以下のコードを実行、存在していなければ実行しない
    priceInput.addEventListener("input", () => {
      //priceInputに対して入力が行われたら実行されるイベントリスナーリスナーを記述
      const inputValue = priceInput.value;
      //入力された、現在値を習得し、inputValueという変数に格納
      const fee = calculateFee(inputValue);
      //calculateFee関数（手数料を計算する）を呼び出し、inputValueを引数として渡している。結果をfee（手数料）という変数に格納します。
      const profit = calculateProfit(inputValue, fee);
      //calculateProfit関数（利益計算をする）を呼び出し、inputValueとfeeを引数として渡します。結果をprofit（利益）という変数に格納します。

      feeOutput.innerHTML = fee;
      //feeOutput要素の内部HTMLをfeeの値に更新。これにより、手数料が表示される。
      profitOutput.innerHTML = profit;
      //profitOutput要素の内部HTMLをprofitの値に更新。これにより、利益が表示される。
    });
  }

  function calculateFee(price) {
    //販売手数料を計算する関数を定義する。
    return Math.floor(price * 0.1);
    //価格の10%を計算(小数点を切り捨てた整数値を返す。)
  }

  function calculateProfit(price) {
    //calculateProfitという名前の関数を定義する。この関数にpriceを引数で受け取る。
    const fee = calculateFee(price);
    //feeという定数を宣言しcalculateFee関数を呼び出してその結果をfeeに格納している。calculateFee(price)は、引数として渡されたprice（アイテムの価格）を基に手数料を計算し、その結果を返します。
    return Math.floor(price - fee);
    //販売利益を計算(小数点を切り捨てた整数値を返す。)
  }
});
