function statWrapper(statWrapperId) {
  wrapper = document.getElementById(statWrapperId)
  return {
    wrapper : wrapper,
    input : wrapper.getElementsByTagName('input')[0],
    progress : wrapper.getElementsByClassName('rpgui-progress')[0],
  }
}

function updateStat(stat, statNbr) {
  stat.input.value = statNbr
  RPGUI.set_value(stat.progress, (statNbr/10))
}

function updateStockView(stockViewId, stockNbr) {
  stockViewId = document.getElementById(stockViewId)
  stockViewId.innerHTML = stockNbr
}

function addStat(statWrapperId, stockInputId, stockViewId) {
  stockInput = document.getElementById(stockInputId)
  stockNbr = parseInt(stockInput.value)
  stat = statWrapper(statWrapperId)

  if (stockNbr > 0 && stat.input.value != '10') {
  stockInput.value = --stockNbr
  updateStockView(stockViewId, stockNbr)
  statNbr = parseInt(stat.input.value)
  ++statNbr
  updateStat(stat, statNbr)
  }
}

function rmStat(statWrapperId, stockInputId, maxStockInputId, stockViewId) {
  maxStock = parseInt(document.getElementById(maxStockInputId).value)
  stockInput = document.getElementById(stockInputId)
  stockNbr = parseInt(stockInput.value)
  stat = statWrapper(statWrapperId)

  if (stockNbr < maxStock && stat.input.value != "0") {
    stockInput.value = ++stockNbr
    updateStockView(stockViewId, stockNbr)
    statNbr = parseInt(stat.input.value)
    --statNbr
    updateStat(stat, statNbr)
  }
}
