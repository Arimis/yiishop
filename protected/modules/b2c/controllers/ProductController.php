<?php
/**
 * 商品详情
 *
 * @author        chenfenghua <843958575@qq.com>
 * @copyright     Copyright (c) 2011-2015 shop. All rights reserved.
 * @link          http://www.yiitian.com
 * @package       /protected/modules/b2c/controllers
 * @version       v1.0.0
 */

class ProductController extends B2cController
{
    /**
     * 商品详情
     */
    public function actionIndex()
    {
        $id = $this->get('id');

        $Product = new ModelProduct();
        $model['product'] = $Product->Item($id);

        if (!$model['product']['row']['goods_id']) {
            $this->redirect('/');
        }

        $cid = $model['product']['row']['cat_id'];
        $Cat = new ModelCat();
        $model['cat'] = $Cat->Item("cat_id = {$cid}");
        $model['parent_cat'] = $Cat->Item("cat_id = {$model['cat']['parent_id']}");

        $this->render('index',array('model'=>$model,'row'=>$model['product']['row'],'image'=>$model['product']['image']));
    }

    /**
     * 预览详情
     */
    public function actionDetail()
    {
        $id = $this->get('id');

        $Product = new ModelProduct();
        $model['product'] = $Product->Item($id);

        echo $this->renderPartial('detail',array('row'=>$model['product']['row'],'image'=>$model['product']['image']),true);
    }
} 