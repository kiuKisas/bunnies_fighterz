//= require waitforelem
//= require stockviewupdater

function statWrapper(statWrapperId) {
  wrapper = document.getElementById(statWrapperId)
  return {
    wrapper : wrapper,
    input : wrapper.getElementsByTagName('input')[0],
    progress : wrapper.getElementsByClassName('rpgui-progress')[0],
  }
}

function initProgBarDOM(statWrapperId, statNbr, statMax = 10) {
  size = (statNbr/statMax)
	waitForElement('.rpgui-progress-fill').then(function(element) {
		stat = statWrapper(statWrapperId)
		RPGUI.set_value(stat.progress, size)
	})
}

function updateProgBarDOM(stat, statNbr) {
  stat.input.value = statNbr
  RPGUI.set_value(stat.progress, (statNbr/10))
}

function addStat(statWrapperId, stockInputId, maxStockInputId) {
  const maxStock = parseInt(document.getElementById(maxStockInputId).value)
  stockInput = document.getElementById(stockInputId)
  stockNbr = parseInt(stockInput.value)
  stat = statWrapper(statWrapperId)

  if (stockNbr > 0 && stat.input.value != '9') {
  stockInput.value = --stockNbr
  incStockView('stock-view', stockNbr)
  statNbr = parseInt(stat.input.value)
  ++statNbr
  updateProgBarDOM(stat, statNbr)
  }
}

function rmStat(statWrapperId, stockInputId, maxStockInputId) {
  const maxStock = parseInt(document.getElementById(maxStockInputId).value)
  stockInput = document.getElementById(stockInputId)
  stockNbr = parseInt(stockInput.value)
  stat = statWrapper(statWrapperId)

  if (stockNbr < maxStock && stat.input.value != "1") {
    stockInput.value = ++stockNbr
    incStockView('stock-view', stockNbr)
    statNbr = parseInt(stat.input.value)
    --statNbr
    updateProgBarDOM(stat, statNbr)
  }
}
