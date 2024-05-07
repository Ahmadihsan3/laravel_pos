<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Dashboard extends Model
{
    use HasFactory;

    protected $fillable = [
        'transaction_time',
        'total_price',
        'total_item',
        'kasir_id',
        'payment_method'
    ];

    public function kasir()
    {
        return $this->belongsTo(User::class, 'kasir_id', 'id');
    }

    public function dashboardItems()
    {
        return $this->hasMany(DashboardItem::class);
    }
}
