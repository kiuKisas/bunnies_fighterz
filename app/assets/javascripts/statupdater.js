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
	waitForElement('.rpgui-progress-fill').then(function(element) {
    const size = (statNbr/10)
		const stat = statWrapper(statWrapperId)
    RPGUI.set_value(stat.progress, size)
	})
}

function updateProgBarDOM(stat, statNbr) {
  stat.input.value = statNbr
  RPGUI.set_value(stat.progress, (statNbr/statNbr))
}

function addStat(statWrapperId, stockInputId, maxStockInputId) {
  // TODO: refacto
  const maxStock = parseInt(document.getElementById(maxStockInputId).value)
  const stockInput = document.getElementById(stockInputId)
  const stat = statWrapper(statWrapperId)
  stockNbr = parseInt(stockInput.value)

  if (stockNbr > 0 && stat.input.value != '9') {
  stockInput.value = --stockNbr
  incStockView('stock-view', stockNbr)
  statNbr = parseInt(stat.input.value)
  ++statNbr
  updateProgBarDOM(stat, statNbr)
  }
}

function rmStat(statWrapperId, stockInputId, maxStockInputId) {
  // TODO: refacto
  const maxStock = parseInt(document.getElementById(maxStockInputId).value)
  const stockInput = document.getElementById(stockInputId)
  const stat = statWrapper(statWrapperId)
  stockNbr = parseInt(stockInput.value)

  if (stockNbr < maxStock && stat.input.value != "1") {
    stockInput.value = ++stockNbr
    incStockView('stock-view', stockNbr)
    statNbr = parseInt(stat.input.value)
    --statNbr
    updateProgBarDOM(stat, statNbr)
  }
}
