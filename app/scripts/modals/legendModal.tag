<legend-modal>
  <div class="modal fade" id="legendModal" tabindex="-1" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">凡例</h4>
        </div>
        <div class="modal-body">
          <table class='table table-striped table-bordered table-condensed'>
            <tr>
              <th>
                <svg width="60px" height="20px">
                  <line x1="0" y1="10" x2="60" y2="10" stroke="#00ffff" stroke-width="5"/>
                </svg>
              </th>
              <td colspan="3">自転車専用道路</td>
            </tr>

            <tr>
              <th>
                <svg width="60px" height="20px">
                  <line x1="0" y1="10" x2="60" y2="10" stroke="#0000ff" stroke-width="5"/>
                </svg>
              </th>
              <td rowspan="4">自転車の走りやすさ</td>
              <td colspan="2">◯</td>
            </tr>

            <tr>
              <th>
                <svg width="60px" height="20px">
                  <line x1="0" y1="10" x2="60" y2="10" stroke="#00ff00" stroke-width="5"/>
                </svg>
              </th>
              <td colspan="2">△</td>
            </tr>

            <tr>
              <th>
                <svg width="60px" height="20px">
                  <line x1="0" y1="10" x2="60" y2="10" stroke="#ff9900" stroke-width="5" stroke-dasharray="5,5"/>
                </svg>
              </th>
              <td rowspan="2">×</td>
              <td>幅の広い歩道あり</td>
            </tr>

            <tr>
              <th>
                <svg width="60px" height="20px">
                  <line x1="0" y1="10" x2="60" y2="10" stroke="#ff00ff" stroke-width="5" stroke-dasharray="5,5"/>
                </svg>
              </th>
              <td>幅の広い歩道なし</td>
            </tr>

            <tr>
              <th>
                <img src="images/bicycle_parking.svg" width="30px" height="30px" />
              </th>
              <td colspan="3">駐輪場(一時利用可) ※1日1回100円</td>
            </tr>

            <tr>
              <th>
                <img src="http://umap.openstreetmap.fr/uploads/pictogram/bicycle-24.png" width="30px" height="30px" />
              </th>
              <td colspan="3">自転車店</td>
            </tr>
          </table>
          <div class="panel panel-primary">
            <div class="panel-heading">凡例の補足</div>
            <ul class="list-group">
              <li class="list-group-item">「◯」は、路肩や車線が広い道路や自動車交通からの威圧感が少ない道路です。</li>
              <li class="list-group-item">「△」は、自転車の通行に十分な路肩幅員はないため、走行に注意が必要な道路です。</li>
              <li class="list-group-item">「×」は、路肩や車線が狭く、自動車交通からの威圧感も多いため、自転車の通行にお勧めできない道路です。
                しかし、幅の広い歩道がある区間では、歩行者に十分注意して歩道を徐行することも可能です。</li>
            </ul>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</legend-modal>
